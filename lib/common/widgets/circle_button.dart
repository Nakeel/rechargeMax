import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Widget? child;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  const CircleButton({
    super.key,
    this.child,
    this.onTap,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8.0),
        child: Material(
          elevation: 0.5,
          borderRadius: BorderRadius.circular(10000),
          child: CircleAvatar(
            backgroundColor: backgroundColor ?? Colors.white,
            child: child,
          ),
        ),
      ),
    );
  }
}
