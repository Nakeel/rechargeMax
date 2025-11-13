import 'package:flutter/material.dart';
import 'package:recharge_max/core/ui/colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.thickness,
    this.padding,
  });
  final double? thickness;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 20),
      child: Divider(
        thickness: thickness ?? 12,
        // color: AppColors.dividerGreen,
        color: AppColors.lightGrey,
      ),
    );
  }
}
