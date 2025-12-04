import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_max/core/ui/colors.dart';

/// Tab selector for switching between Airtime and Data recharge options.
///
/// Displays two tabs: "Airtime" and "Data" with animated underline indicator.
class AirtimeDataTabsWidget extends StatelessWidget {
  final int selectedTab;
  final Function(int) onTabChanged;

  const AirtimeDataTabsWidget({
    Key? key,
    required this.selectedTab,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => onTabChanged(0),
            child: Column(
              children: [
                Text(
                  'Airtime',
                  style: TextStyle(
                    color: selectedTab == 0
                        ? AppColors.colorPrimary
                        : AppColors.descTextGrey,
                    fontSize: 14.sp,
                    fontWeight:
                        selectedTab == 0 ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 3.h,
                  decoration: BoxDecoration(
                    color: selectedTab == 0
                        ? AppColors.colorPrimary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 24.w),
        Expanded(
          child: GestureDetector(
            onTap: () => onTabChanged(1),
            child: Column(
              children: [
                Text(
                  'Data',
                  style: TextStyle(
                    color: selectedTab == 1
                        ? AppColors.colorPrimary
                        : AppColors.descTextGrey,
                    fontSize: 14.sp,
                    fontWeight:
                        selectedTab == 1 ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 3.h,
                  decoration: BoxDecoration(
                    color: selectedTab == 1
                        ? AppColors.colorPrimary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
