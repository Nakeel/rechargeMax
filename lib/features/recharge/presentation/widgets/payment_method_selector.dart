import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recharge_max/core/ui/colors.dart';

class PaymentMethodSelector extends StatefulWidget {
  final Function(String) onMethodSelected;

  const PaymentMethodSelector({
    Key? key,
    required this.onMethodSelected,
  }) : super(key: key);

  @override
  State<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  int _selectedMethod = 0; // 0: Bank Transfer, 1: Card

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: TextStyle(
            color: AppColors.colorBlack,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        _buildPaymentOption(
          0,
          'assets/svg/bankTransfer.svg',
          'Pay with Bank Transfer',
        ),
        SizedBox(height: 12.h),
        _buildPaymentOption(
          1,
          'assets/svg/card.svg',
          'Pay with Card',
        ),
      ],
    );
  }

  Widget _buildPaymentOption(int index, String icon, String label) {
    final isSelected = _selectedMethod == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = index;
        });
        widget.onMethodSelected(label);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.colorPrimary.withOpacity(0.05) : Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.colorPrimary : AppColors.naturalGrey,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 24.w,
              height: 24.w,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColors.colorPrimary : AppColors.descTextGrey,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? AppColors.colorPrimary : AppColors.colorBlack,
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: isSelected ? AppColors.colorPrimary : AppColors.descTextGrey,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}
