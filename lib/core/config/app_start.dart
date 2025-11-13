import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recharge_max/core/abstractions/build_config.dart';
import 'package:recharge_max/core/abstractions/feature_resolver.dart';
import 'package:recharge_max/core/abstractions/router_module.dart';
import 'package:recharge_max/core/providers/providers.dart';
import 'package:recharge_max/core/resolver/app_resolver.dart';
import 'package:recharge_max/core/router/app_router.dart';
import 'package:recharge_max/main.dart';
import 'package:recharge_max/my_app.dart';

import 'app_set_up.dart';

// import 'package:auto_orientation/auto_orientation.dart';

// GlobalKey<ScaffoldState> navScaffoldKey = GlobalKey<ScaffoldState>();
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// GlobalKey<NavigatorState> goRouterNavigatorKey = GlobalKey<NavigatorState>();
late GoRouter goRouter;
late BuildContext globalContext;

abstract class AppStart {
  final BuildConfig buildConfig;

  final resolvers = <FeatureResolver>[
    BaseAppResolver(),
  ];

  final routerModule = <RouterModule>[];

  AppStart(this.buildConfig);

  GoRouter generateRoute(List<RouterModule> routerModule, {String? index, Map<String, dynamic>? extras}) {
    // GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    // itereate all router modueles and create go router object
    List<RouteBase> routeBase = [];
    for (var element in routerModule) {
      element.getRoutes().forEach((route) {
        routeBase.add(route);
      });
    }
    goRouter = GoRouter(
        // debugLogDiagnostics: true,
        initialLocation: index ?? '/',
        // navigatorKey: navigatorKey,
        navigatorKey: rootNavigatorKey,
        initialExtra: extras,
        routes: routeBase,
      observers: [
        // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
      ],
    );
    return goRouter;
  }

  Future initModules() async {
    for (final resolver in resolvers) {
      if (resolver.routerModule != null) {
        routerModule.add(resolver.routerModule!);
      }
    }
  }

  Future<void> startApp() async {
    await runZonedGuarded<Future<void>>(() async {
      await AppSetUp().init();
      await initModules();
      runApp(
        Phoenix(
          child:
          // MultiBlocProvider(
            // providers: providers,
            // child:
          ProviderScope(
              child:
              MyApp(
                buildConfig: buildConfig,
                routes: generateRoute(
                  routerModule,
                ),
              ),
            ),
          // ),
        ),
      );
    }, (onError, stackTrace) {
      log(onError.toString(), stackTrace: stackTrace);
    });
  }
}
