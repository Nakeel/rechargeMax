import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  final Dio dio;
  AppInterceptor({
    required this.dio,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.contentType = 'application/json';
    options.headers['Accept'] = 'application/json';
    return handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    handler.next(response);
  }
}
