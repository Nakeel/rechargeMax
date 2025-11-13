import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerPlaceholder {
  /// A static method to generate a shimmer loader with customizable properties.
  static Widget create({
    double? width,
    double? height,
    BoxShape? boxShape,
    BorderRadius? borderRadius,
    Color? baseColor,
    Color? highlightColor,
  }) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade500,
      highlightColor: highlightColor ?? Colors.grey.shade200,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade600,
          shape: boxShape ?? BoxShape.rectangle,
          borderRadius:boxShape==BoxShape.circle ? null:borderRadius ?? BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

