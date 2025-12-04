import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_max/core/ui/colors.dart';

/// Tab selector for switching between Airtime and Data recharge options.
///
/// Displays pill-shaped tabs: "Airtime" and "Data" with smooth transitions.
/// Selected tab has blue background with white text.
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
    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          _buildTabButton(
            label: 'Airtime',
            isSelected: selectedTab == 0,
            onTap: () => onTabChanged(0),
          ),
          SizedBox(width: 12.w),
          _buildTabButton(
            label: 'Data',
            isSelected: selectedTab == 1,
            onTap: () => onTabChanged(1),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.colorPrimary : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.colorBlack,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
