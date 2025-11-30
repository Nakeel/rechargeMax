import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:recharge_max/core/router/route_name.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:recharge_max/core/ui/assets.dart';
import 'package:recharge_max/features/dashboard/presentation/widgets/quick_recharge_card.dart';
import 'package:recharge_max/features/dashboard/presentation/widgets/quick_action_button.dart';
import 'package:recharge_max/features/dashboard/presentation/widgets/jackpot_card.dart';
import 'package:recharge_max/features/dashboard/presentation/widgets/recent_winners_section.dart';
import 'package:recharge_max/features/dashboard/presentation/widgets/loyalty_tier_section.dart';
import 'package:recharge_max/features/dashboard/presentation/widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(),

                SizedBox(height: 24.h),

                // Greeting Section
                _buildGreeting(),

                SizedBox(height: 24.h),

                // Quick Recharge Card
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: QuickRechargeCard(
                    onTap: () {
                      context.go(AppRoutes.rechargeRoute);
                    },
                  ),
                ),

                SizedBox(height: 24.h),

                // Quick Action Buttons
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: _buildQuickActions(),
                ),

                SizedBox(height: 32.h),

                // Today's Jackpot
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const JackpotCard(),
                ),

                SizedBox(height: 32.h),

                // Recent Winners
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const RecentWinnersSection(),
                ),

                SizedBox(height: 32.h),

                // Loyalty Tier
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const LoyaltyTierSection(),
                ),

                SizedBox(height: 100.h), // Space for bottom nav
              ],
            ),
          ),

          // Bottom Navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavBar(
              selectedIndex: _selectedNavIndex,
              onItemSelected: (index) {
                setState(() {
                  _selectedNavIndex = index;
                });

                // Navigate based on selected index
                switch (index) {
                  case 0:
                    // Home - already on home screen
                    break;
                  case 1:
                    // Recharge
                    context.go(AppRoutes.rechargeRoute);
                    break;
                  case 2:
                    // Draw
                    context.go(AppRoutes.spinWheelRoute);
                    break;
                  case 3:
                    // Wallet (Transactions)
                    context.go(AppRoutes.transactionsRoute);
                    break;
                  case 4:
                    // Profile
                    // TODO: Navigate to profile screen when available
                    break;
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppColors.colorPrimary,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            Row(
              children: [
                SvgPicture.asset(
                  Assets.logoSvg,
                  width: 24.w,
                  height: 24.w,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                SizedBox(width: 8.w),
                Text(
                  'RechargeMax',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            // Notification and Profile
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    'assets/svg/bell.svg',
                    width: 24.w,
                    height: 24.w,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
                SizedBox(width: 16.w),
                GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 16.r,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: Icon(
                      Icons.person,
                      size: 18.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello!',
            style: TextStyle(
              color: AppColors.colorBlack,
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '+234 xxx xxx xxx',
            style: TextStyle(
              color: AppColors.descTextGrey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: QuickActionButton(
            icon: 'assets/svg/subQuicklink.svg',
            label: 'Subscribe\n(₦20/day)',
            onTap: () {
              context.go(AppRoutes.rechargeRoute);
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: QuickActionButton(
            icon: 'assets/svg/buyDataQuicklink.svg',
            label: 'Buy Data',
            onTap: () {
              context.go(AppRoutes.rechargeRoute);
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: QuickActionButton(
            icon: 'assets/svg/buyDataQuicklink.svg',
            label: 'Buy Data',
            onTap: () {
              context.go(AppRoutes.rechargeRoute);
            },
          ),
        ),
      ],
    );
  }
}
