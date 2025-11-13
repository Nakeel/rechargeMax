import 'package:dio/dio.dart';

import 'exceptions.dart';

class ErrorInterceptor extends BaseErrorMapperInterceptor {
  @override
  void mapError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        return handler.reject(ConnectTimeoutException(err.requestOptions));
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.badCertificate:
        return handler.reject(DeadlineExceededException(err.requestOptions));
      case DioExceptionType.badResponse:
        final code = err.response?.statusCode;
        switch (code) {
          case 400:
            return handler.reject(BadRequestException(res: err.response, r: err.requestOptions));
          case 401:
            return handler.reject(UnauthorizedException(res: err.response, r: err.requestOptions));
          case 422:
            return handler.reject(UnprocessableContentException(res: err.response, r: err.requestOptions));
          case 404:
            return handler.reject(NotFoundException(res: err.response, r: err.requestOptions));
          case 406:
            return handler.reject(InCompleteRegistrationException(res: err.response, r: err.requestOptions));
          case 409:
            return handler.reject(ConflictException(res: err.response, r: err.requestOptions));
          case 500:
          case 503:
            return handler.reject(InternalServerErrorException(res: err.response, r: err.requestOptions));
          default:
            return handler.reject(UnknownException(res: err.response, r: err.requestOptions));
        }
      case DioExceptionType.cancel:
        return handler.reject(err);
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return handler.reject(NoInternetConnectionException(err.requestOptions));
    }
  }
}



abstract class BaseErrorMapperInterceptor extends Interceptor {
  void mapError(DioException err, ErrorInterceptorHandler handler);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err is RefreshTokenException) return handler.next(err);
    mapError(err, handler);
  }
}
