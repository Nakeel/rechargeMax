import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:recharge_max/core/ui/assets.dart';
import 'package:recharge_max/core/ui/colors.dart';

class ImageWidgetWithShimmerLoader extends StatelessWidget {
  const ImageWidgetWithShimmerLoader({
    Key? key,
    required this.image,
    this.shape = 'round', // 'round' or 'circle'
    this.loadingWidget,
    this.errorWidget,
    this.height,
    this.width,
    this.highlightColor,
    this.baseColor,
    this.fit,
  }) : super(key: key);

  final String image;
  final String shape; // 'round' or 'circle'
  final Widget? loadingWidget, errorWidget;
  final double? height, width;
  final Color? highlightColor, baseColor;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    final img = Image.network(
      image,
      height: height ?? 130,
      width: width ?? 130,
      fit: fit ?? BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;

        return loadingWidget ??
            Shimmer.fromColors(
              baseColor: baseColor ?? Colors.grey[700]!,
              highlightColor: highlightColor ?? Colors.grey[300]!,
              child: SizedBox(
                width: width ?? 100,
                height: height ?? 100,
              ),
            );
      },
      errorBuilder: (context, exception, stackTrace) {
        return errorWidget ??
            SizedBox(
              width: (width ?? 100) - 30,
              height: (height ?? 100) - 30,
              child: SvgPicture.asset(Assets.productPlaceholder),
            );
      },
    );

    // Shape handling
    if (shape == 'circle') {
      return ClipOval(child: img);
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: img,
      );
    }
  }
}
