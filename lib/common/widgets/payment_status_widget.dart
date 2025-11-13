import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:recharge_max/core/ui/colors.dart';

class PaymentStatusWidget extends StatelessWidget {
  final String status;

  const PaymentStatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final statusLower = status.toLowerCase();

    if (statusLower == 'upcoming') {
      return DottedBorder(
        color: AppColors.deepGreen,
        borderType: BorderType.RRect,
        radius: const Radius.circular(8),
        dashPattern: const [4, 3],
        strokeWidth: 1,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.green300,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            status,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.deepGreen,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    }

    final color = statusLower == 'due'
        ? AppColors.colorRed
        : statusLower == 'paid'
            ? AppColors.green800
            : AppColors.grey50;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
