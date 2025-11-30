import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recharge_max/core/abstractions/router_module.dart';
import 'package:recharge_max/features/auth/presentation/screens/auth_flow_screen.dart';
import 'package:recharge_max/features/dashboard/presentation/screens/home_screen.dart';
import 'package:recharge_max/features/dashboard/presentation/screens/shell_layout.dart';
import 'package:recharge_max/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:recharge_max/features/profile/presentation/screens/profile_screen.dart';
import 'package:recharge_max/features/recharge/presentation/screens/recharge_screen.dart';
import 'package:recharge_max/features/spinWheel/presentation/screen/custom_spin_the_wheel_widget.dart';
import 'package:recharge_max/features/splash/presentation/splash_screen.dart';
import 'package:recharge_max/features/spinWheel/presentation/screen/spin_wheel_screen.dart';
import 'package:recharge_max/features/wallet/presentation/screens/wallet_screen.dart';

import 'route_name.dart';

late StatefulNavigationShell navigationShell;
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

// Shell route navigator keys for each branch
final GlobalKey<NavigatorState> _shellNavigatorHomeKey =
    GlobalKey<NavigatorState>(debugLabel: 'homeShell');
final GlobalKey<NavigatorState> _shellNavigatorRechargeKey =
    GlobalKey<NavigatorState>(debugLabel: 'rechargeShell');
final GlobalKey<NavigatorState> _shellNavigatorDrawKey =
    GlobalKey<NavigatorState>(debugLabel: 'drawShell');
final GlobalKey<NavigatorState> _shellNavigatorWalletKey =
    GlobalKey<NavigatorState>(debugLabel: 'walletShell');
final GlobalKey<NavigatorState> _shellNavigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'profileShell');

class BaseAppRouteModule implements RouterModule {
  // final _shellNavigatorHomeKey =
  //     GlobalKey<NavigatorState>(debugLabel: AppRoutes.homeRoute);

  // //
  // final _shellNavigatorCatalogKey =
  //     GlobalKey<NavigatorState>(debugLabel: AppRoutes.catalogRoute);

  // final _shellNavigatorCartKey =
  //     GlobalKey<NavigatorState>(debugLabel: AppRoutes.cartRoute);

  // final _shellNavigatorOrdersKey =
  //     GlobalKey<NavigatorState>(debugLabel: AppRoutes.ordersRoute);

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: AppRoutes.indexSplash,
        name: AppRoutes.indexSplash,
        builder: (context, state) => const MainSplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboardingRoute,
        name: AppRoutes.onboardingRoute,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: OnboardingScreen(
              key: state.pageKey,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.signinRoute,
        name: AppRoutes.signinRoute,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: const AuthFlowScreen(),
          );
        },
      ),
      // Shell route with bottom navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ShellLayout(navigationShell: navigationShell);
        },
        branches: [
          // Home branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeKey,
            routes: [
              GoRoute(
                path: AppRoutes.homeRoute,
                name: AppRoutes.homeRoute,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    child: const HomeScreen(),
                  );
                },
              ),
            ],
          ),
          // Recharge branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorRechargeKey,
            routes: [
              GoRoute(
                path: AppRoutes.rechargeRoute,
                name: AppRoutes.rechargeRoute,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    child: const RechargeScreen(),
                  );
                },
              ),
            ],
          ),
          // Draw/Spin Wheel branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDrawKey,
            routes: [
              GoRoute(
                path: AppRoutes.spinWheelRoute,
                name: AppRoutes.spinWheelRoute,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    child: SpinTheWheelScreen(
                      key: state.pageKey,
                    ),
                  );
                },
              ),
            ],
          ),
          // Wallet branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorWalletKey,
            routes: [
              GoRoute(
                path: AppRoutes.transactionsRoute,
                name: AppRoutes.transactionsRoute,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    child: const WalletScreen(),
                  );
                },
              ),
            ],
          ),
          // Profile branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfileKey,
            routes: [
              GoRoute(
                path: AppRoutes.profileRoute,
                name: AppRoutes.profileRoute,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    child: const ProfileScreen(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ];
  }
}
