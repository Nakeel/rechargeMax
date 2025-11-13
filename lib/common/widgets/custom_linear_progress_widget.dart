import 'package:flutter/material.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:recharge_max/core/utils/app_logger.dart';

class CustomLinearProgressWidget extends StatelessWidget {
  final double progress;
  final Duration duration;
  final double height;
  final Color backgroundColor;
  final Color color;
  final BorderRadiusGeometry borderRadius;

  const CustomLinearProgressWidget({
    super.key,
    required this.progress,
    this.duration = const Duration(milliseconds: 500),
    this.height = 13,
    this.backgroundColor = AppColors.lightGreen,
    this.color = AppColors.colorPrimary,
    this.borderRadius = const BorderRadius.all(Radius.circular(2)),
  });

  @override
  Widget build(BuildContext context) {
    AppLogger.info('progress $progress');
    return TweenAnimationBuilder<double>(
      duration: duration,
      tween: Tween(begin: 0, end: progress),
      builder: (context, value, _) {
        return ClipRRect(
          borderRadius: borderRadius,
          child: LinearProgressIndicator(
            borderRadius: BorderRadius.circular(4),
            value: value,
            minHeight: height,
            backgroundColor: backgroundColor,
            color: color,
          ),
        );
      },
    );
  }
}
