import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recharge_max/core/abstractions/router_module.dart';
import 'package:recharge_max/features/auth/presentation/screens/auth_flow_screen.dart';
import 'package:recharge_max/features/dashboard/presentation/screens/home_screen.dart';
import 'package:recharge_max/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:recharge_max/features/recharge/presentation/screens/recharge_screen.dart';
import 'package:recharge_max/features/spinWheel/presentation/screen/custom_spin_the_wheel_widget.dart';
import 'package:recharge_max/features/splash/presentation/splash_screen.dart';
import 'package:recharge_max/features/spinWheel/presentation/screen/spin_wheel_screen.dart';
import 'package:recharge_max/features/wallet/presentation/screens/transactions_screen.dart';

import 'route_name.dart';

late StatefulNavigationShell navigationShell;
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

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
      GoRoute(
        path: AppRoutes.homeRoute,
        name: AppRoutes.homeRoute,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: const HomeScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.rechargeRoute,
        name: AppRoutes.rechargeRoute,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: const RechargeScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.transactionsRoute,
        name: AppRoutes.transactionsRoute,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: const TransactionsScreen(),
          );
        },
      ),
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

      //new page holder
      // StatefulShellRoute.indexedStack(
      //   builder: (context, state, navigationShell) {
      //     return NewPageHolder(child: navigationShell);
      //   },
      //   branches: [
      //     //newDashboard
      //     StatefulShellBranch(
      //       routes: [
      //         GoRoute(
      //           path: AppRoutes.newHomeRoute,
      //           name: AppRoutes.newHomeRoute,
      //           pageBuilder: (context, state) {
      //             return MaterialPage(
      //               child: NewDashboardScreen(
      //                 key: state.pageKey,
      //               ),
      //             );
      //           },
      //         ),
      //       ],
      //     ),
      //     //rent finance history
      //     StatefulShellBranch(
      //       routes: [
      //         GoRoute(
      //           path: AppRoutes.rentFinanceHistoryRoute,
      //           name: AppRoutes.rentFinanceHistoryRoute,
      //           pageBuilder: (context, state) {
      //             return MaterialPage(
      //               child: RentFinanceHistory(
      //                 key: state.pageKey,
      //               ),
      //             );
      //           },
      //         ),
      //       ],
      //     ),
      //     //marketplace
      //     StatefulShellBranch(
      //       routes: [
      //         GoRoute(
      //           path: AppRoutes.marketplaceRoute,
      //           name: AppRoutes.marketplaceRoute,
      //           pageBuilder: (context, state) {
      //             return NoTransitionPage(
      //               child: MainMarketPlaceHomeScreen(
      //                 key: state.pageKey,
      //               ),
      //             );
      //           },
      //           routes: [
      //             GoRoute(
      //               path: AppRoutes.filteredProductRoute,
      //               name: AppRoutes.filteredProductRoute,
      //               pageBuilder: (context, state) {
      //                 return MaterialPage(
      //                   child: MainFilteredCategoryScreen(
      //                     key: state.pageKey,
      //                     data: state.extra as Map<String, dynamic>,
      //                   ),
      //                 );
      //               },
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    ];
  }
}
