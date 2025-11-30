
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recharge_max/core/constants/app_string_constants.dart';
import 'package:recharge_max/core/router/route_name.dart';
import 'package:recharge_max/core/storage/cache.dart';
import 'package:recharge_max/core/ui/assets.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:recharge_max/core/utils/app_logger.dart';

class MainSplashScreen extends StatefulWidget {
  const MainSplashScreen({super.key});

  @override
  State<MainSplashScreen> createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        // Wait for animation to complete before navigating
        await Future.delayed(const Duration(milliseconds: 2500));
        if (mounted) {
          await getNextRoute();
        }
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> getNextRoute() async {
    try {
      final hasOpened = await CacheStorage.readData(AppConstants.hasOpened) ?? false;
      AppLogger.info('Routing - Has opened $hasOpened');

      if (!hasOpened) {
        if (mounted) {
          context.go(AppRoutes.onboardingRoute);
        }
        return;
      }

      final hasLogin = await CacheStorage.readData(AppConstants.hasLogin) ?? false;
      AppLogger.info('Routing - hasLogin $hasLogin');

      if (mounted) {
        context.go(AppRoutes.spinWheelRoute);
      }
    } catch (e) {
      AppLogger.error('Error in getNextRoute: $e');
      if (mounted) {
        context.go(AppRoutes.onboardingRoute);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      body: Stack(
        children: [
          Image.asset(
            Assets.logoBg,
            fit: BoxFit.cover,
          ),
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Image.asset(
                  Assets.appLogo,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

