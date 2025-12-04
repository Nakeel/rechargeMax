import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:recharge_max/core/ui/app_theme.dart';
import 'package:recharge_max/core/ui/colors.dart';

/// A simple, flexible AppBar widget for standard screen layouts.
///
/// Provides configurable title, background color, back button, and actions.
/// Perfect for screens that need a clean, consistent header.
class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final double? elevation;
  final double? titleFontSize;

  const SimpleAppBar({
    Key? key,
    required this.title,
    this.backgroundColor = Colors.white,
    this.textColor = AppColors.colorBlack,
    this.showBackButton = true,
    this.onBackPressed,
    this.actions,
    this.elevation = 2,
    this.titleFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      leading: showBackButton
          ? GestureDetector(
              onTap: onBackPressed ?? () => context.pop(),
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.colorPrimary,
                size: 24.sp,
              ),
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: titleFontSize ?? 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
