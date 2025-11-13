import 'package:dio/dio.dart';
import 'package:recharge_max/core/constants/app_string_constants.dart';
import 'package:recharge_max/core/network/api_routes.dart';
import 'package:recharge_max/core/network/dio/base_api.dart';
import 'package:recharge_max/core/resolver/init_dependencies.dart';
import 'package:recharge_max/core/storage/cache.dart';

import 'exceptions.dart';

class TokenRefresherInterceptor extends Interceptor {
  final Dio dio;

  static const loginEndpoints = [
    ApiRouteConstant.signup,
    ApiRouteConstant.login,
    ApiRouteConstant.refreshToken,
  ];

  TokenRefresherInterceptor({required this.dio});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final requestPath = err.requestOptions.uri.path;
    if (loginEndpoints.contains(requestPath)) {
      return super.onError(err, handler);
    }
    if (err.response?.statusCode == 401) {
      bool isRefreshed = false;
      try {
        isRefreshed = await _refreshToken();
      } catch (e) {
        return handler.next(RefreshTokenException(r: err.requestOptions));
      }
      if (isRefreshed) {
        // Retry the request with the new token
        final options = err.requestOptions;
        options.headers['Authorization'] = dio.options.headers['Authorization'];
        final response = await dio.request(
          options.path,
          options: Options(
            method: options.method,
            headers: options.headers,
          ),
          data: options.data,
          queryParameters: options.queryParameters,
        );
        return handler.resolve(response);
      }
    }
    return handler.next(err);
  }

  Future<bool> _refreshToken() async {
    // Retrieve the refresh token
    final refreshToken = await CacheStorage.readData(AppConstants.refreshToken);
    if (refreshToken == null) {
      throw Exception();
    }
    serviceLocator<BaseAppApiClient>().setBearerToken(refreshToken);
    // Call refresh token API
    final response = await dio
        .post(ApiRouteConstant.refreshToken, data: {"sourceService": "udux"});

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.data['data'];
      final newToken = data.tokens?.accessToken ?? '';
      serviceLocator<BaseAppApiClient>().setBearerToken(newToken);
      final newRefreshToken = data.tokens?.refreshToken ?? '';

      // Save the new tokens
      CacheStorage.saveData(AppConstants.accessToken, newToken);
      CacheStorage.saveData('token', newToken);
      CacheStorage.saveData(AppConstants.refreshToken, newRefreshToken);

      // Update Dio headers with the new token
      dio.options.headers['Authorization'] = 'Bearer $newToken';

      return true;
    } else if (response.statusCode == 401) {
      throw RefreshTokenException(r: response.requestOptions);
    }
    return false;
  }
}
