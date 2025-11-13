import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:recharge_max/core/ui/assets.dart';

import '../../core/ui/colors.dart';
import 'circular_button_widget.dart';

class InnerClassCustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final Color backgroundColor;
  final bool hasBackButton;
  final Color? textColor;

  const InnerClassCustomAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.actions,
    this.hasBackButton = true,
    this.backgroundColor = AppColors.deepGreen,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: preferredSize.height,
        color: backgroundColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Centered Title
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? AppColors.colorWhite,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Left side (Back Button)
            if (hasBackButton)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CircleIconButton(
                    iconAsset: Assets.back,
                    onTap: onBack ?? () => context.pop(),
                    iconSize: 15,
                    padding: 15,
                    size: 55,
                  ),
                ),
              ),

            // Right side (Actions)
            if (actions != null && actions!.isNotEmpty)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions!,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
