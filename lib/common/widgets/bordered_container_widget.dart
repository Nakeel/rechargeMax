import 'package:flutter/material.dart';

class BorderedContainerWidget extends StatelessWidget {
  const BorderedContainerWidget({Key? key, required this.child, this.padding, this.borderRadius,
    this.color, this.borderColor,
    this.hideBorder = false,
  }) : super(key: key);
  final Widget child;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Color? color, borderColor;
  final bool hideBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        border: hideBorder ? null: Border.all(
            color: borderColor?? const Color(0xFFE4E6E8), width: 1),
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
