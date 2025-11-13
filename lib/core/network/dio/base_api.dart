import 'dart:developer';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:recharge_max/core/network/dio/app_interceptor.dart';
import 'package:recharge_max/core/network/env.dart';

import 'error_interceptor.dart';
import 'logging_interceptor.dart';
import 'refresh_token_logout_interceptor.dart';
import 'token_refresher_interceptor.dart';

class BaseAppApiClient {
  late Dio dio;

  BaseAppApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: Env.getConfig.baseUrl,
        receiveTimeout: const Duration(minutes: 1),
        connectTimeout: const Duration(minutes: 1),
        sendTimeout: const Duration(minutes: 1),
      ),
    );

    dio.interceptors.addAll([
      LoggingInterceptor(level: Level.body),
      AppInterceptor(dio: dio),
      RefreshTokenLogoutInterceptor(),
      // RetryInterceptor(dio: dio),
      ErrorInterceptor(),
    ]);
    dio.options.followRedirects = true;
    dio.options.maxRedirects = 4;
  }

  void setBearerToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
    dio.options.headers['Accept'] = 'application/json';
  }

  void clearBearerToken() {
    dio.options.headers.remove('Authorization');
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
    void Function(int progress, int total)? progress,
  }) async {
    try {
      return await dio.get(
        url,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: progress,
      );
    } on DioException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    void Function(int progress, int total)? sendProgress,
    void Function(int progress, int total)? receiveProgress,
  }) async {
    try {
      return await dio.post(
        url,
        data: data,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: sendProgress,
        onReceiveProgress: receiveProgress,
      );
    } on DioException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // Repeat similar methods for PUT, PATCH, DELETE, etc.
  // Include URI-specific variants if needed.

  Future<Response> download(
    String url,
    dynamic savePath, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    void Function(int progress, int total)? progress,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
  }) async {
    try {
      return await dio.download(
        url,
        savePath,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: progress,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
      );
    } on DioException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? token,
    Function(int progress, int total)? sendProgress,
    Function(int progress, int total)? receiveProgress,
  }) async {
    try {
      return await dio.put(
        url,
        data: data,
        queryParameters: params,
        options: options,
        cancelToken: token,
        onReceiveProgress: receiveProgress,
        onSendProgress: sendProgress,
      );
    } on DioException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> patch(
    String url, {
    dynamic data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? token,
    Function(int progress, int total)? sendProgress,
    Function(int progress, int total)? receiveProgress,
  }) async {
    try {
      return await dio.patch(
        url,
        data: data,
        queryParameters: params,
        options: options,
        cancelToken: token,
        onReceiveProgress: receiveProgress,
        onSendProgress: sendProgress,
      );
    } on DioException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? token,
  }) async {
    try {
      return await dio.delete(
        url,
        data: data,
        queryParameters: params,
        options: options,
        cancelToken: token,
      );
    } on DioException catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
