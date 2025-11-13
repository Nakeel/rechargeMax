import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:recharge_max/core/abstractions/build_config.dart';
import 'package:recharge_max/core/ui/app_theme.dart';

class MyApp extends StatelessWidget {
  final BuildConfig buildConfig;
  final GoRouter routes;

  const MyApp({
    Key? key,
    required this.buildConfig,
    required this.routes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ScreenUtilInit(
        designSize: const Size(414, 896),
        builder: (context, child) => child!,
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp.router(
          key: const ValueKey('goRouterApp'),
          locale: const Locale('en', 'NG'),
          routerDelegate: routes.routerDelegate,
          routeInformationParser: routes.routeInformationParser,
          routeInformationProvider: routes.routeInformationProvider,
          title: buildConfig.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme(context),
          themeMode: ThemeMode.light,
        ),
      ),
    );
  }
}