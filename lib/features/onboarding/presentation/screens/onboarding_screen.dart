import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:recharge_max/common/widgets/app_button.dart';
import 'package:recharge_max/core/router/route_name.dart';
import 'package:recharge_max/core/ui/assets.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<OnboardingPage> pages = [
    OnboardingPage(
      title: 'Recharge & Win Daily',
      description: 'Every ₦200 you spend on recharge earns you entries into our daily and weekly draws with amazing prizes.',
      image: Assets.onboardingMagnifier,
      backgroundColor: const Color(0xFFF5F5F5),
    ),
    OnboardingPage(
      title: 'Instant Gratification',
      description: 'Recharge ₦1,000 or more and spin the wheel for instant prizes including data bundles, airtime, and bonus entries.',
      image: Assets.onboardingWheel,
      backgroundColor: const Color(0xFFF5F5F5),
    ),
    OnboardingPage(
      title: 'Loyalty Pays',
      description: 'The more you recharge, the higher your tier. Higher tiers mean better multipliers and more chances to win.',
      image: Assets.onboardingTrophy,
      backgroundColor: const Color(0xFFF5F5F5),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _skipOnboarding() {
    context.go(AppRoutes.signinRoute);
  }

  void _nextPage() {
    if (_currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _skipOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _skipOnboarding,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: AppColors.colorBlack,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            // Page view
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(pages[index]);
                },
              ),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: pages.length,
              effect:  ExpandingDotsEffect(
                  dotColor: AppColors.naturalGrey,
                  activeDotColor: AppColors.colorPrimary,
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 8,
                  expansionFactor: 2
              ),
            ),
            const SizedBox(height: 24),
            // Page indicator and buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Smooth page indicator
                  AppButton.fill(context: context,
                      text: _currentPage == pages.length - 1 ? 'Get Started' : 'Next',
                      onPressed: _nextPage,
                    size:  Size(double.infinity, 48.h)
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(page.image,
            height: 280,
            width: 280,
            errorBuilder: (context, _, _,){
            return Container(
              height: 280,
              width: 280,
              decoration: BoxDecoration(
                color: page.backgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Icon(
                  Icons.image_not_supported,
                  size: 64,
                  color: Colors.grey,
                ),
              ),
            );
            },
          ),
          const SizedBox(height: 28),
          // Title
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          // Description
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF111827),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String image;
  final Color backgroundColor;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.image,
    required this.backgroundColor,
  });
}
