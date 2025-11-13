import 'package:flutter/material.dart';
import 'package:recharge_max/core/ui/colors.dart';

import 'image_shimmer_widget_loader.dart';

class ProductImageCardWidget extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final double containerHeight;
  final double containerWidth;
  final double borderRadius;
  final BoxFit fit;
  final Widget? errorWidget;
  final bool hasBorder;
  final EdgeInsets? padding;

  const ProductImageCardWidget({
    super.key,
    required this.image,
    this.height = 100,
    this.width = 100,
    this.fit = BoxFit.contain,
    this.containerHeight = 150,
    this.containerWidth = 150,
    this.borderRadius = 8,
    this.hasBorder = false,
    this.errorWidget,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(borderRadius),
          border: hasBorder
              ? Border.all(
                  color: AppColors.green200.withAlpha((.2 * 255).round()),
                )
              : null),
      height: containerHeight,
      width: containerWidth,
      child: Padding(
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ImageWidgetWithShimmerLoader(
          image: image,
          height: height,
          width: width,
          fit: fit,
          errorWidget: errorWidget,
        ),
      ),
    );
  }
}
