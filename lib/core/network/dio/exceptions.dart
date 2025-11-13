import 'dart:developer';

import 'package:dio/dio.dart';

String _parseResponseData(dynamic data, String defaultMessage) {
  if (data is Map<String, dynamic>) {
    return data['message']?.toString() ?? defaultMessage;
  } else if (data is String) {
    return data;
  } else if (data is List) {
    return data.isNotEmpty ? data.join(', ') : defaultMessage;
  }
  return defaultMessage;
}

class BadRequestException extends DioException {
  Response? res;
  BadRequestException({this.res, required RequestOptions r})
      : super(requestOptions: r, response: res);

  @override
  String toString() {
    return _parseResponseData(res?.data, 'Bad request.\nContact support.');
  }
}

class UnprocessableContentException extends DioException {
  Response? res;
  UnprocessableContentException({this.res, required RequestOptions r})
      : super(requestOptions: r, response: res);

  @override
  String toString() {
    return _parseResponseData(
        res?.data, 'Unprocessable content.\nContact support.');
  }
}

class ConflictException extends DioException {
  Response? res;
  ConflictException({this.res, required RequestOptions r})
      : super(requestOptions: r, response: res);

  @override
  String toString() {
    return _parseResponseData(res?.data, 'Conflict error.\nContact support.');
  }
}

class ConnectTimeoutException extends DioException {
  ConnectTimeoutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Connection timeout';
  }
}

class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out.\nPlease try again.';
  }
}

class InternalServerErrorException extends DioException {
  Response? res;
  InternalServerErrorException({this.res, required RequestOptions r})
      : super(requestOptions: r, response: res);

  @override
  String toString() {
    return _parseResponseData(
        res?.data, 'Internal server error.\nPlease contact support.');
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection to the internet has been lost.\nPlease try again.';
  }
}

class NotFoundException extends DioException {
  Response? res;
  NotFoundException({this.res, required RequestOptions r})
      : super(requestOptions: r, response: res);

  @override
  String toString() {
    return _parseResponseData(
        res?.data, 'Something went wrong.\nPlease try again.');
  }
}

class InCompleteRegistrationException extends DioException {
  Response? res;
  InCompleteRegistrationException({this.res, required RequestOptions r})
      : super(requestOptions: r, response: res);

  @override
  String toString() {
    return 'AppConstants.incompleteRegistration';
  }
}

class RequestEntityTooLargeException extends DioException {
  RequestEntityTooLargeException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Request too large';
  }
}

class UnauthorizedException extends DioException {
  Response? res;
  UnauthorizedException({this.res, required RequestOptions r})
      : super(requestOptions: r, response: res);

  @override
  String toString() {
    return _parseResponseData(
        res?.data, 'Unauthorized user error.\nPlease logout and login.');
  }
}

class RefreshTokenException extends DioException {
  Response? res;
  RefreshTokenException({this.res, required RequestOptions r})
      : super(requestOptions: r, response: res);

  @override
  String toString() {
    return _parseResponseData(res?.data, 'Refresh token expired.');
  }
}

class UnknownException extends DioException {
  Response? res;
  UnknownException({this.res, required RequestOptions r})
      : super(requestOptions: r, response: res);

  @override
  String toString() {
    return _parseResponseData(
        res?.data, 'Something went wrong.\nPlease try again.');
  }
}
