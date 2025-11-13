import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:recharge_max/core/utils/app_logger.dart';

/// Log Level
enum Level {
  /// No logs.
  none,

  /// Logs request and response lines.
  ///
  /// Example:
  ///  ```
  ///  --> POST /greeting
  ///
  ///  <-- 200 OK
  ///  ```
  basic,

  /// Logs request and response lines and their respective headers.
  ///
  ///  Example:
  /// ```
  /// --> POST /greeting
  /// Host: example.com
  /// Content-Type: plain/text
  /// Content-Length: 3
  /// --> END POST
  ///
  /// <-- 200 OK
  /// Content-Type: plain/text
  /// Content-Length: 6
  /// <-- END HTTP
  /// ```
  headers,

  /// Logs request and response lines and their respective headers and bodies (if present).
  ///
  /// Example:
  /// ```
  /// --> POST /greeting
  /// Host: example.com
  /// Content-Type: plain/text
  /// Content-Length: 3
  ///
  /// Hi?
  /// --> END POST
  ///
  /// <-- 200 OK
  /// Content-Type: plain/text
  /// Content-Length: 6
  ///
  /// Hello!
  /// <-- END HTTP
  /// ```
  body,
}

/// DioLoggingInterceptor
/// Simple logging interceptor for dio.
///
/// Inspired the okhttp-logging-interceptor and referred to pretty_dio_logger.
class LoggingInterceptor extends Interceptor {
  /// Log Level
  final Level level;

  /// Log printer; defaults logPrint log to console.
  /// In flutter, you'd better use debugPrint.
  /// you can also write log in a file.
  void Function(Object object) logPrint;

  /// Print compact json response
  final bool compact;

  final JsonDecoder decoder = const JsonDecoder();
  final JsonEncoder encoder = const JsonEncoder.withIndent('  ');

  LoggingInterceptor({
    this.level = Level.body,
    this.compact = false,
    this.logPrint = print,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (level == Level.none) {
      return handler.next(options);
    }

    AppLogger.info('====================================== -->OnRequest ${options.method} ${options.uri} ======================================');

    if (level == Level.basic) {
      return handler.next(options);
    }

    AppLogger.info('[DIO][HEADERS]');
    options.headers.forEach((key, value) {
      AppLogger.info('$key:$value');
    });

    if (level == Level.headers) {
      AppLogger.info('====================================== [DIO][HEADERS]--> END ${options.method} ======================================');
      return handler.next(options);
    }

    final data = options.data;
    if (data != null) {
      AppLogger.info('====================================== [DIO]dataType:${data.runtimeType} ======================================');
      if (data is Map) {
        if (compact) {
          AppLogger.info('$data');
        } else {
          _prettyPrintJson(data);
        }
      } else if (data is FormData) {
        // NOT IMPLEMENT
      } else {
        AppLogger.info(data.toString());
      }
    }

    AppLogger.info('====================================== [DIO]--> END ${options.method} ======================================');

    return handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (level == Level.none) {
      return handler.next(response);
    }

    AppLogger.info(
        '<-- ${response.statusCode} ${(response.statusMessage?.isNotEmpty ?? false) ? response.statusMessage : '' '${response.requestOptions.uri}'}');

    if (level == Level.basic) {
      return handler.next(response);
    }

    AppLogger.info('====================== OnResponse [DIO][HEADER]======================================');
    AppLogger.info(
        '<----- ${response.requestOptions.uri} ----->');

    response.headers.forEach((key, value) {
      AppLogger.info('$key:$value');
    });
    AppLogger.info('================================[DIO][HEADERS]<-- END ${response.requestOptions.method}===========================');
    if (level == Level.headers) {
      return handler.next(response);
    }
    final data = response.data;
    if (data != null) {
      AppLogger.info('======================================[DIO]dataType:${data.runtimeType}===================================');
      if (data is Map) {
        if (compact) {
          AppLogger.info('$data');
        } else {
          _prettyPrintJson(data);
        }
      } else if (data is List) {
        // NOT IMPLEMENT
      } else {
        AppLogger.info(data.toString());
      }
    }

    AppLogger.info('===================================[DIO]<-- END HTTP ===================================');
    return handler.next(response);
  }

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) {
    if (level == Level.none) {
      return handler.next(err);
    }

    final request = err.requestOptions;
    final response = err.response;

    if (response != null) {
      _logResponseHeaders(response);
    }

    AppLogger.error(
      '🛑 [DIO][ERROR] <-- HTTP FAILED: ${err.type} | ${request.method} ${request.uri} | ${err.message}',
    );

    return handler.next(err);
  }

  void _logResponseHeaders(Response response) {
    final method = response.requestOptions.method;
    AppLogger.error('🔻 [DIO][RESPONSE HEADERS START] ====================================');
    response.headers.forEach((key, values) {
      AppLogger.error('$key: ${values.join(', ')}');
    });
    AppLogger.error('🔺 [DIO][RESPONSE HEADERS END $method] ================================');
  }


  void _prettyPrintJson(Object input) {
    final prettyString = encoder.convert(input);
    AppLogger.info('=================================== <-- Response payload ===================================');
    prettyString.split('\n').forEach((element) => AppLogger.info(element));
  }
}
