
import 'package:flutter/material.dart';
import 'package:recharge_max/core/ui/colors.dart';

class CustomTooltip extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;
  final double? maxWidth;
  final Color backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final EdgeInsets padding;

  const CustomTooltip({
    super.key,
    required this.title,
    required this.description,
    required this.child,
    this.maxWidth,
    this.backgroundColor = Colors.black,
    this.titleStyle,
    this.descriptionStyle,
    this.padding = const EdgeInsets.all(12),
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      triggerMode: TooltipTriggerMode.tap, // tap to show on mobile
      padding: EdgeInsets.zero, // remove default padding
      showDuration: Duration(seconds: 8),
      decoration: BoxDecoration(
        color: Colors.transparent, // We'll handle background ourselves
      ),
      richMessage: WidgetSpan(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth ?? 250),
          child: Material(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
            elevation: 4,
            child: Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: titleStyle ??
                        const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: descriptionStyle ??
                         TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.hintGrey,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      child: child,
    );
  }
}
