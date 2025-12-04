import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_max/core/ui/colors.dart';

/// Quick amount selector with preset button options.
///
/// Displays quick-select buttons for common recharge amounts.
/// Allows user to tap a button to select an amount.
class QuickAmountSelector extends StatelessWidget {
  final List<int> amounts;
  final int? selectedAmount;
  final Function(int) onAmountSelected;

  const QuickAmountSelector({
    Key? key,
    this.amounts = const [200, 500, 1000, 5000],
    this.selectedAmount,
    required this.onAmountSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: amounts.map((amount) {
        final isSelected = selectedAmount == amount;
        return GestureDetector(
          onTap: () => onAmountSelected(amount),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.colorPrimary.withValues(alpha: 0.1)
                  : Colors.white,
              border: Border.all(
                color:
                    isSelected ? AppColors.colorPrimary : AppColors.naturalGrey,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              '₦$amount',
              style: TextStyle(
                color:
                    isSelected ? AppColors.colorPrimary : AppColors.colorBlack,
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
