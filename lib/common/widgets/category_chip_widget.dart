import 'package:flutter/material.dart';
import 'package:recharge_max/common/widgets/app_text.dart';
import 'package:recharge_max/core/ui/colors.dart';

class SelectedCategoryChipWidget extends StatelessWidget {
  final String label;
  final VoidCallback onDeleted;

  const SelectedCategoryChipWidget({
    super.key,
    required this.label,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: TextView(
        text: label,
        color: AppColors.grey50, // Text color
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      deleteIcon: Icon(
        Icons.cancel,
        color: AppColors.grey50, // Close icon color
        size: 18, // Icon size
      ),
      onDeleted: onDeleted,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      backgroundColor: Colors.white,
      side: BorderSide(
        color: AppColors.grey150, // Border color
      ),
    );
  }
}
