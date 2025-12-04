import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_max/core/ui/colors.dart';

/// Information banner showing draw entries information.
///
/// Displays details about entries earned from recharge
/// and mentions prize wheel spin opportunity.
class EntriesInfoBanner extends StatelessWidget {
  final String? message;

  const EntriesInfoBanner({
    Key? key,
    this.message = "You'll earn 2 entries into today's draw, plus a spin on the prize wheel!",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.colorPrimary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        message ?? '',
        style: TextStyle(
          color: AppColors.colorPrimary,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
