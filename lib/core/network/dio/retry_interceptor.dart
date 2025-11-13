import 'dart:async';
import 'dart:developer' as devtools show log;
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:recharge_max/core/utils/app_logger.dart';

import 'exceptions.dart';

typedef RetryEvaluator = FutureOr<bool> Function(DioException error);

/// Refactored RetryOptions with a default maximum retry count of 5.
/// The default evaluator now only retries on server errors (5xx) and network errors.
class RetryOptions {
  /// Maximum number of retry attempts.
  final int retries;

  /// Interval before each retry.
  final Duration retryInterval;

  /// Custom evaluator for determining if a retry is needed.
  RetryEvaluator get retryEvaluator => _retryEvaluator ?? defaultRetryEvaluator;

  final RetryEvaluator? _retryEvaluator;

  const RetryOptions({
    this.retries = 5, // Default to 5 retries.
    RetryEvaluator? retryEvaluator,
    this.retryInterval = const Duration(milliseconds: 500),
  }) : _retryEvaluator = retryEvaluator;

  factory RetryOptions.noRetry() => const RetryOptions(retries: 0);

  static const extraKey = 'cache_retry_request';

  /// Default retry evaluator:
  /// - Does not retry if the request was cancelled.
  /// - Does not retry on client errors (400, 401, 404).
  /// - Retries on server errors (5xx) and network connectivity issues.
  static FutureOr<bool> defaultRetryEvaluator(DioException error) async {
    // Do not retry if cancelled.
    if (error.type == DioExceptionType.cancel) {
      return false;
    }
    // Retry when refresh token is invalid
    if (error is RefreshTokenException) {
      return false;
    }
    // Check for client error status codes.
    final statusCode = error.response?.statusCode;
    if (statusCode != null && (statusCode == 400 || statusCode == 401 || statusCode == 404)) {
      return false;
    }
    // Retry for server errors (5xx) or network errors.
    if (statusCode != null && statusCode >= 500 && statusCode < 600) {
      return true;
    }
    // Retry on network connectivity issues (socket exception)
    if (error.error is SocketException || error.type == DioExceptionType.connectionTimeout) {
      return true;
    }
    return false;
  }

  /// Retrieves retry options from request extras or falls back to default options.
  factory RetryOptions.fromExtra(RequestOptions request, RetryOptions defaultOptions) {
    return request.extra[extraKey] ?? defaultOptions;
  }

  /// Creates a copy with modified retries or retry interval.
  RetryOptions copyWith({
    int? retries,
    Duration? retryInterval,
  }) =>
      RetryOptions(
        retries: retries ?? this.retries,
        retryInterval: retryInterval ?? this.retryInterval,
      );

  Map<String, dynamic> toExtra() => {extraKey: this};

  Options toOptions() => Options(extra: toExtra());

  Options mergeIn(Options options) {
    return options.copyWith(extra: {...?options.extra, ...toExtra()});
  }

  /// Determines if the request should continue retrying based on the current attempt.
  bool shouldRetry(int attempt) {
    return attempt < retries;
  }

  @override
  String toString() {
    return 'RetryOptions{retries: $retries, retryInterval: $retryInterval, _retryEvaluator: $_retryEvaluator}';
  }
}


/// A Dio interceptor that implements exponential backoff with jitter for automatic retrying of failed HTTP requests.
class RetryInterceptor extends Interceptor {
  /// Dio instance used to make the request retries.
  final Dio dio;

  /// Options to configure retry behavior (like number of attempts, retry interval, etc.).
  final RetryOptions options;

  /// Whether to log retry attempts for debugging purposes.
  final bool shouldLog;

  /// Maximum backoff duration in milliseconds to prevent excessively long waits between retries.
  /// Defaults to 30,000 ms (30 seconds).
  final int maxBackoffMilliseconds;

  /// HTTP status codes that should not be retried.
  static final _nonRetryableStatusCodes = {400, 401, 403, 404};

  /// Creates a [RetryInterceptor] with configurable retry options.
  ///
  /// [dio] - The Dio instance used for retrying requests.
  /// [options] - Configurable retry options; defaults to [RetryOptions] if not provided.
  /// [shouldLog] - If true, logs retry attempts to the console; defaults to true.
  /// [maxBackoffMilliseconds] - Maximum delay for exponential backoff in milliseconds;
  /// defaults to 30,000 ms (30 seconds).
  RetryInterceptor({
    required this.dio,
    RetryOptions? options,
    this.shouldLog = true,
    this.maxBackoffMilliseconds = 30000, // Default to 30 seconds
  }) : options = options ?? const RetryOptions();

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    int attempt = 0;
    var extra = RetryOptions.fromExtra(err.requestOptions, options);

    // Check if the request is eligible for retry
    bool shouldRetry = await options.retryEvaluator(err);
    if (!shouldRetry ||
        _nonRetryableStatusCodes.contains(err.response?.statusCode)) {
      // If not retryable, pass the error to the next handler
      AppLogger.info('[${err.requestOptions.uri}] Not retrying request due to error type: ${err.type}');
      return super.onError(err, handler);
    }

    // Retry logic
    while (attempt < extra.retries) {
      // Calculate exponential backoff delay: baseInterval * 2^attempt
      int backoffMilliseconds = extra.retryInterval.inMilliseconds * (1 << attempt);

      // Cap the backoff to avoid excessively long delays
      backoffMilliseconds = min(backoffMilliseconds, maxBackoffMilliseconds);

      // Add jitter to avoid retry spikes and synchronized retries
      backoffMilliseconds += (backoffMilliseconds * 0.2 * (1 - 2 * (Random().nextDouble()))).toInt();

      // Log retry attempt
      AppLogger.info(
          '[${err.requestOptions.uri}] Retrying request... Attempt: ${attempt + 1} of ${extra.retries} after ${backoffMilliseconds}ms');

      // Create a Completer and Timer to handle backoff and cancellation
      final completer = Completer<void>();
      final timer = Timer(Duration(milliseconds: backoffMilliseconds), completer.complete);

      try {
        // Wait for the timer to complete or request cancellation
        await completer.future;

        // If the request is cancelled, stop retrying
        if (err.requestOptions.cancelToken?.isCancelled ?? false) {
          timer.cancel();
          AppLogger.info('[${err.requestOptions.uri}] Request cancelled, stopping retries.');
          handler.next(err);
          return;
        }

        // Retry the request using the same options as the original request
        final response = await dio.request(
          err.requestOptions.path,
          cancelToken: err.requestOptions.cancelToken,
          data: err.requestOptions.data,
          onReceiveProgress: err.requestOptions.onReceiveProgress,
          onSendProgress: err.requestOptions.onSendProgress,
          queryParameters: err.requestOptions.queryParameters,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
            sendTimeout: err.requestOptions.sendTimeout,
            receiveTimeout: err.requestOptions.receiveTimeout,
            responseType: err.requestOptions.responseType,
            contentType: err.requestOptions.contentType,
            extra: err.requestOptions.extra,
            validateStatus: err.requestOptions.validateStatus,
            followRedirects: err.requestOptions.followRedirects,
            receiveDataWhenStatusError:
                err.requestOptions.receiveDataWhenStatusError,
            maxRedirects: err.requestOptions.maxRedirects,
            requestEncoder: err.requestOptions.requestEncoder,
            responseDecoder: err.requestOptions.responseDecoder,
            listFormat: err.requestOptions.listFormat,
          ),
        );

        // Log successful response
        AppLogger.info('[${err.requestOptions.uri}] Retry successful on attempt: ${attempt + 1}');
        // Resolve the request if it succeeds
        return handler.resolve(response);
      } catch (error) {
        // Log error details before catching
        AppLogger.info('[${err.requestOptions.uri}] Error caught during retry attempt: $attempt. Error: $error');

        // Capture the error and update the attempt count
        attempt++;

        // Log retry failure and attempt count
        AppLogger.info('[${err.requestOptions.uri}] Retry failed on attempt: $attempt due to: $error');

        // If the error is not retryable or max attempts reached, stop retrying
        if (!await options.retryEvaluator(err) ||
            _nonRetryableStatusCodes.contains(err.response?.statusCode) ||
            attempt >= extra.retries) {
          AppLogger.info('[${err.requestOptions.uri}] Max retries reached or non-retryable error, aborting retries.');
          break;
        }
      } finally {
        // Ensure the timer is canceled to avoid memory leaks
        timer.cancel();
      }
    }

    // Pass the error to the next handler after retries are exhausted
    handler.next(err);
  }

}

/// Extension to convert RequestOptions to Options.
extension RequestOptionsExtensions on RequestOptions {
  Options toOptions() {
    return Options(
      method: method,
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      extra: extra,
      headers: headers,
      responseType: responseType,
      contentType: contentType,
      validateStatus: validateStatus,
      receiveDataWhenStatusError: receiveDataWhenStatusError,
      followRedirects: followRedirects,
      maxRedirects: maxRedirects,
      requestEncoder: requestEncoder,
      responseDecoder: responseDecoder,
      listFormat: listFormat,
    );
  }
}


// typedef RetryEvaluator = FutureOr<bool> Function(DioException error);
//
// /// Refactored RetryOptions with a default maximum retry count of 5.
// /// The default evaluator now only retries on server errors (5xx) and network errors.
// class RetryOptions {
//   /// Maximum number of retry attempts.
//   final int retries;
//
//   /// Custom evaluator for determining if a retry is needed.
//   RetryEvaluator get retryEvaluator => _retryEvaluator ?? defaultRetryEvaluator;
//
//   final RetryEvaluator? _retryEvaluator;
//
//   const RetryOptions({
//     this.retries = 5, // Default to 5 retries.
//     RetryEvaluator? retryEvaluator,
//   }) : _retryEvaluator = retryEvaluator;
//
//   factory RetryOptions.noRetry() => const RetryOptions(retries: 0);
//
//   static const extraKey = 'cache_retry_request';
//
//   /// Default retry evaluator:
//   /// - Does not retry if the request was cancelled.
//   /// - Does not retry on client errors (400, 401, 404).
//   /// - Retries on server errors (5xx) and network connectivity issues.
//   static FutureOr<bool> defaultRetryEvaluator(DioException error) async {
//     // Do not retry if cancelled.
//     if (error.type == DioExceptionType.cancel) {
//       return false;
//     }
//     // Check for client error status codes.
//     final statusCode = error.response?.statusCode;
//     if (statusCode != null && (statusCode == 400 || statusCode == 401 || statusCode == 404)) {
//       return false;
//     }
//     // Retry for server errors (5xx) or network errors.
//     if (statusCode != null && statusCode >= 500 && statusCode < 600) {
//       return true;
//     }
//     // Retry on network connectivity issues (socket exception)
//     if (error.error is SocketException || error.type == DioExceptionType.connectionTimeout) {
//       return true;
//     }
//     return false;
//   }
//
//   /// Retrieves retry options from request extras or falls back to default options.
//   factory RetryOptions.fromExtra(RequestOptions request, RetryOptions defaultOptions) {
//     return request.extra[extraKey] ?? defaultOptions;
//   }
//
//   /// Creates a copy with modified retries.
//   RetryOptions copyWith({
//     int? retries,
//   }) =>
//       RetryOptions(
//         retries: retries ?? this.retries,
//       );
//
//   Map<String, dynamic> toExtra() => {extraKey: this};
//
//   Options toOptions() => Options(extra: toExtra());
//
//   Options mergeIn(Options options) {
//     return options.copyWith(extra: {...?options.extra, ...toExtra()});
//   }
//
//   /// Determines if the request should continue retrying based on the current attempt.
//   bool shouldRetry(int attempt) {
//     return attempt < retries;
//   }
//
//   @override
//   String toString() {
//     return 'RetryOptions{retries: $retries, _retryEvaluator: $_retryEvaluator}';
//   }
// }
//
// /// A Dio interceptor that implements retry logic based on the number of retries.
// class RetryInterceptor extends Interceptor {
//   /// Dio instance used to make the request retries.
//   final Dio dio;
//
//   /// Options to configure retry behavior (like number of attempts).
//   final RetryOptions options;
//
//   /// Whether to log retry attempts for debugging purposes.
//   final bool shouldLog;
//
//   /// HTTP status codes that should not be retried.
//   static final _nonRetryableStatusCodes = {401, };
//
//   /// Creates a [RetryInterceptor] with configurable retry options.
//   ///
//   /// [dio] - The Dio instance used for retrying requests.
//   /// [options] - Configurable retry options; defaults to [RetryOptions] if not provided.
//   /// [shouldLog] - If true, logs retry attempts to the console; defaults to true.
//   RetryInterceptor({
//     required this.dio,
//     RetryOptions? options,
//     this.shouldLog = true,
//   }) : options = options ?? const RetryOptions();
//
//   @override
//   Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
//     int attempt = 0;
//     var extra = RetryOptions.fromExtra(err.requestOptions, options);
//
//     // Check if the request is eligible for retry
//     bool shouldRetry = await options.retryEvaluator(err);
//     if (!shouldRetry || _nonRetryableStatusCodes.contains(err.response?.statusCode)) {
//       // If not retryable, pass the error to the next handler
//       AppLogger.info('[${err.requestOptions.uri}] Not retrying request due to error type: ${err.type}');
//       return super.onError(err, handler);
//     }
//
//     // Retry logic based on retry count only (no backoff).
//     while (attempt < extra.retries) {
//       attempt++; // Increment attempt number on each retry.
//
//       // Log retry attempt
//       AppLogger.info('[${err.requestOptions.uri}] Retrying request... Attempt: $attempt of ${extra.retries}');
//
//       try {
//         // Retry the request
//         final response = await dio.request(
//           err.requestOptions.path,
//           cancelToken: err.requestOptions.cancelToken,
//           data: err.requestOptions.data,
//           onReceiveProgress: err.requestOptions.onReceiveProgress,
//           onSendProgress: err.requestOptions.onSendProgress,
//           queryParameters: err.requestOptions.queryParameters,
//           options: Options(
//             method: err.requestOptions.method,
//             headers: err.requestOptions.headers,
//             sendTimeout: err.requestOptions.sendTimeout,
//             receiveTimeout: err.requestOptions.receiveTimeout,
//             responseType: err.requestOptions.responseType,
//             contentType: err.requestOptions.contentType,
//             extra: err.requestOptions.extra,
//             validateStatus: err.requestOptions.validateStatus,
//             followRedirects: err.requestOptions.followRedirects,
//             receiveDataWhenStatusError: err.requestOptions.receiveDataWhenStatusError,
//             maxRedirects: err.requestOptions.maxRedirects,
//             requestEncoder: err.requestOptions.requestEncoder,
//             responseDecoder: err.requestOptions.responseDecoder,
//             listFormat: err.requestOptions.listFormat,
//           ),
//         );
//
//         // Log successful response
//         AppLogger.info('[${err.requestOptions.uri}] Retry successful on attempt: $attempt');
//         // Resolve the request if it succeeds
//         return handler.resolve(response);
//       } catch (error) {
//         // Log error details before catching
//         AppLogger.info('[${err.requestOptions.uri}] Error caught during retry attempt: $attempt. Error: $error');
//
//         // Log retry failure and attempt count
//         AppLogger.info('[${err.requestOptions.uri}] Retry failed on attempt: $attempt due to: $error');
//
//         // If the error is not retryable or max attempts reached, stop retrying
//         if (!await options.retryEvaluator(err) ||
//             _nonRetryableStatusCodes.contains(err.response?.statusCode) ||
//             attempt >= extra.retries) {
//           AppLogger.info('[${err.requestOptions.uri}] Max retries reached or non-retryable error, aborting retries.');
//           break;
//         }
//       }
//     }
//
//     // Pass the error to the next handler after retries are exhausted
//     handler.next(err);
//   }
//
// }


