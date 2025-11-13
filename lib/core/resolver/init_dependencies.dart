
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:recharge_max/core/network/dio/base_api.dart';
import 'package:recharge_max/core/network/env.dart';

import 'auth_dependencies.dart';


final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {

  
  _initFeatures();

  serviceLocator
    ..registerLazySingleton<Dio>(() => Dio(BaseOptions(baseUrl: Env.getConfig.baseUrl, followRedirects: true)))

  ..registerLazySingleton(
      () => BaseAppApiClient());

  // ..registerLazySingleton<GoRouter>(
  // () => goRouter);
}

_initFeatures() {
  // getAuthDependencies();
}
