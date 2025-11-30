import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:recharge_max/core/constants/app_string_constants.dart';
import 'package:recharge_max/core/ui/app_theme.dart';
import 'package:recharge_max/core/ui/colors.dart';


// Helper widget for summary rows
class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Widget? titleWidget;
  final bool isLoading;
  final bool isCurrency;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
    this.titleWidget,
    this.isLoading = false,
    this.isCurrency = false,
  });

  Widget shimmerBox({double height = 16, double width = double.infinity, BorderRadius? radius}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: radius ?? BorderRadius.circular(4),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
      fontWeight: isBold ? FontWeight.w500 :FontWeight.w400,
      fontSize: 14,
      color:   isBold ? AppColors.black100 : AppColors.grey50,
    );
    final valStyle = TextStyle(
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
      fontSize:isBold ? 16: 14,
      color:  AppColors.black100,
      fontFamily: isCurrency ? AppTheme.roboto : AppTheme.opensans
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label, style: labelStyle),
              if(titleWidget != null)...[
                const SizedBox(width: 8),
                titleWidget!,
              ]
            ],
          ),
          isLoading ? shimmerBox(height: 14, width: 30)
              :
          Text(isCurrency ? '${AppConstants.nairaSymbol}$value' : value, style: valStyle),
        ],
      ),
    );
  }
}