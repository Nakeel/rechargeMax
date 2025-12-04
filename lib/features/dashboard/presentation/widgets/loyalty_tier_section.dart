import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_max/core/ui/app_theme.dart';
import 'package:recharge_max/core/ui/assets.dart';
import 'package:recharge_max/core/ui/colors.dart';
class LoyaltyTierCard extends StatelessWidget {
  final LoyaltyTierConfig config;
  final double progress;           // 0.0 – 1.0
  final String progressLabel;      // e.g. "20 Points to next tier"

  const LoyaltyTierCard({
    super.key,
    required this.config,
    required this.progress,
    required this.progressLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            config.backgroundTop,
            config.backgroundMiddle,
            config.backgroundBottom,
          ],
          stops: [0.0, .4, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // LEFT CONTENT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Your Loyalty Tier",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.sp,
                          fontFamily: AppTheme.roboto,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 6.h),

                      Text(
                        config.tierName,
                        style: TextStyle(
                          color: config.accentColor,
                          fontSize: 26.sp,
                          fontFamily: AppTheme.roboto,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      SizedBox(height: 2.h),

                      Text(
                        config.tierSubtitle,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      SizedBox(height: 14.h),

                    ],
                  ),
                ),

                SizedBox(width: 16.w),

                // RIGHT BADGE
                Image.asset(
                  config.badgeAsset,
                  width: 100.w,
                  height: 100.w,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),

          // PROGRESS BAR + LABEL

          Container(
            decoration: BoxDecoration(
              color: AppColors.colorWhite.withOpacity(.37),
              borderRadius: BorderRadius.circular(20.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w,).copyWith(top: 10, bottom: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 5.h,
                    backgroundColor: Colors.black.withOpacity(.1),
                    valueColor:
                    AlwaysStoppedAnimation<Color>(config.progressColor),
                  ),
                ),
                // SizedBox(height: 6.h),
                Text(
                  progressLabel,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class LoyaltyTierConfig {
  final String tierName;       // e.g. "SILVER"
  final String tierSubtitle;   // e.g. "TIER MEMBER"
  final String badgeAsset;     // icon asset
  final Color accentColor;     // gold/silver/bronze primary
  final Color progressColor;   // progress bar fill
  final Color backgroundTop;   // gradient start
  final Color backgroundMiddle;// gradient middle
  final Color backgroundBottom;// gradient end

  const LoyaltyTierConfig({
    required this.tierName,
    required this.tierSubtitle,
    required this.badgeAsset,
    required this.accentColor,
    required this.progressColor,
    required this.backgroundTop,
    required this.backgroundBottom,
    required this.backgroundMiddle,
  });

  // Predefined static themes
  static LoyaltyTierConfig silver = LoyaltyTierConfig(
    tierName: "SILVER",
    tierSubtitle: "TIER MEMBER",
    badgeAsset: Assets.silverTier,
    accentColor: AppColors.colorSilver,
    progressColor: Color(0xFFFFB300), // yellow stripe
    backgroundTop: Color(0xFFD7D7D7),
    backgroundBottom:Color(0xFFB9B9B9) ,
    backgroundMiddle: Color(0xFFF3F3F3),
  );

  static LoyaltyTierConfig gold = LoyaltyTierConfig(
    tierName: "GOLD",
    tierSubtitle: "TIER MEMBER",
    badgeAsset: Assets.goldTier,
    accentColor: Color(0xFFFFC107),
    progressColor: Color(0xFFFFA000),
    backgroundTop: Color(0xFFFFE082),
    backgroundMiddle: Color(0xFFFFF3E0),
    backgroundBottom: Color(0xFFFFC107),
  );

  static LoyaltyTierConfig bronze = LoyaltyTierConfig(
    tierName: "BRONZE",
    tierSubtitle: "TIER MEMBER",
    badgeAsset: Assets.bronzeTier,
    accentColor: Color(0xFF8D6E63),
    backgroundBottom: Color(0xFF8D6E63),
    progressColor: Color(0xFF8D6E63),
    backgroundMiddle: Color(0xFFEFEBE9),
    backgroundTop: Color(0xFFD7CCC8),
  );
}
