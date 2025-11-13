import 'package:dio/dio.dart';

import 'exceptions.dart';

class RefreshTokenLogoutInterceptor extends Interceptor {
  RefreshTokenLogoutInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err is RefreshTokenException) {
      // Trigger logout when refresh token fails
      // serviceLocator<AuthBloc>().add(LogoutEvent());
    }
    super.onError(err, handler);
  }
}
