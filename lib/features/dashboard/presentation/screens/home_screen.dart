import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:recharge_max/core/router/route_name.dart';
import 'package:recharge_max/core/ui/app_theme.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:recharge_max/core/ui/assets.dart';
import 'package:recharge_max/features/dashboard/presentation/widgets/quick_recharge_card.dart';
import 'package:recharge_max/features/dashboard/presentation/widgets/quick_action_button.dart';
import 'package:recharge_max/features/dashboard/presentation/widgets/jackpot_card.dart';
import 'package:recharge_max/features/dashboard/presentation/widgets/recent_winners_section.dart';
import 'package:recharge_max/features/dashboard/presentation/widgets/loyalty_tier_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey250,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(context),


            SizedBox(height: 24.h),

            // Quick Action Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: _buildQuickActions(context),
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
              child: LoyaltyTierCard(
                config: LoyaltyTierConfig.silver,
                progress: 0.2,
                progressLabel: "10 Points to next tier",
              ),
            ),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        color: AppColors.colorPrimary,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                        fontSize: 14.sp,
                        fontFamily: AppTheme.roboto,
                        fontWeight: FontWeight.w700,
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
            SizedBox(height: 24.h),

            // Greeting Section
            _buildGreeting(),

            SizedBox(height: 24.h),

            // Quick Recharge Card
            QuickRechargeCard(
              onTap: () {
                context.go(AppRoutes.rechargeRoute);
              },
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello!',
          style: TextStyle(
            color: AppColors.colorWhite,
            fontSize: 24.sp,
            fontFamily: AppTheme.roboto,
            fontWeight: FontWeight.w700,
          ),
        ),
        // SizedBox(height: 4.h),
        Text(
          '+234 xxx xxx xxx',
          style: TextStyle(
            color: AppColors.colorWhite,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
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
