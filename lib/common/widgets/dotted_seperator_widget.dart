
import 'package:flutter/material.dart';
import 'package:recharge_max/core/ui/colors.dart';

class HorizontalDottedSeparator extends StatelessWidget {
  const HorizontalDottedSeparator({Key? key, this.height = 1, this.color})
      : super(key: key);
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 3.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color ?? AppColors.deepGreen.withAlpha((.1 * 255).round())),
              ),
            );
          }),
        );
      },
    );
  }
}


class VerticalDottedSeparator extends StatelessWidget {
  const VerticalDottedSeparator(
      {Key? key, this.width = 1, this.color, this.height})
      : super(key: key);
  final double width;
  final Color? color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxHeight = constraints.constrainHeight();
        final dashHeight = height ??  5.0;
        final dashWidth = width;
        final dashCount = (boxHeight > 0) ? (boxHeight / (2 * dashHeight)).floor() : 0;
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.vertical,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color:color?? AppColors.deepGreen.withAlpha((.1 * 255).round())),
              ),
            );
          }),
        );
      },
    );
  }
}