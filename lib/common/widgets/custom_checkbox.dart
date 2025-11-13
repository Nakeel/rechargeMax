import 'package:flutter/material.dart';
import 'package:recharge_max/core/ui/colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool? value;
  final ValueChanged<bool?> onChanged;
  final BorderSide? borderSide;
  final Color? activeColor;
  final Color? checkColor;
  final BorderRadius? borderRadius;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.borderSide = const BorderSide(color: Colors.grey, width: 1),
    this.activeColor ,
    this.checkColor ,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius!,
      ),
      side: borderSide!,
      activeColor: activeColor ?? AppColors.colorPrimary,
      checkColor: checkColor ?? AppColors.colorWhite,
    );
  }
}
