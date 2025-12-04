import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recharge_max/core/ui/colors.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 16.h,
        left: 12.w,
        right: 12.w,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 8.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(0, 'assets/svg/homeNav.svg', 'Home'),
                _buildNavItem(1, 'assets/svg/reachargeNav.svg', 'Recharge'),
                _buildNavItem(2, 'assets/svg/drawNav.svg', 'Draw'),
                _buildNavItem(3, 'assets/svg/walletNav.svg', 'Wallet'),
                _buildNavItem(4, 'assets/svg/peopleQuicklink.svg', 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath, String label) {
    final isSelected = selectedIndex == index;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onItemSelected(index),
          splashColor: AppColors.colorPrimary.withValues(alpha: 0.1),
          highlightColor: AppColors.colorPrimary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.colorPrimary.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: SvgPicture.asset(
                    iconPath,
                    width: 24.w,
                    height: 24.w,
                    colorFilter: ColorFilter.mode(
                      isSelected
                          ? AppColors.colorPrimary
                          : AppColors.descTextGrey,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected
                        ? AppColors.colorPrimary
                        : AppColors.descTextGrey,
                    fontSize: 10.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
