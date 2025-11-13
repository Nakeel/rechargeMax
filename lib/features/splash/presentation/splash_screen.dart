
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recharge_max/core/constants/app_string_constants.dart';
import 'package:recharge_max/core/router/route_name.dart';
import 'package:recharge_max/core/storage/cache.dart';
import 'package:recharge_max/core/utils/app_logger.dart';

class MainSplashScreen extends StatefulWidget {
  const MainSplashScreen({super.key});

  @override
  State<MainSplashScreen> createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        await getNextRoute();
      }
    });
  }




  Future<void> getNextRoute() async {
    try {
      final hasOpened = await CacheStorage.readData(AppConstants.hasOpened) ?? false;
      AppLogger.info('Routing - Has opened $hasOpened');

      if (!hasOpened) {
        context.go(AppRoutes.spinWheelRoute);
        return;
      }

      final hasLogin = await CacheStorage.readData(AppConstants.hasLogin) ?? false;
      AppLogger.info('Routing - hasLogin $hasLogin');

      // if (hasLogin) {
      //
      //   final keepLogin = await CacheStorage.readData(AppConstants.keepLogin) ?? false;
      //   if(keepLogin) {
      //     context.read<AuthBloc>().add(RefreshTokenEvent());
      //   }else{
      //     context.go(AppRoutes.signinRoute);
      //   }
      // } else {
      //   context.go(AppRoutes.signupRoute);
      // }
    } catch (e) {
      context.go(AppRoutes.spinWheelRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      // BlocListener<AuthBloc, AuthState>(
      // listenWhen: (prev, curr) =>
      // prev.refreshTokenStatus != curr.refreshTokenStatus,
      // listener: (context, state) {
      //   if (state.refreshTokenStatus == ResponseStatus.success) {
      //     /// ✅ Token refreshed, go home
      //     context.go(AppRoutes.newHomeRoute);
      //   } else if (state.refreshTokenStatus == ResponseStatus.failure) {
      //     /// ❌ Refresh failed, send to login
      //     context.go(AppRoutes.returnSigninRoute);
      //   }
      // },
      // child:
      const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    // );
  }
}

