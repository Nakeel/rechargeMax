import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recharge_max/core/ui/colors.dart';

class CircleIconButton extends StatelessWidget {
  final String iconAsset;
  final VoidCallback? onTap;
  final Color backgroundColor, iconColor;
  final double size, iconSize;
  final double padding;
  final double elevation;
  final int? count; // optional badge count

  const CircleIconButton({
    super.key,
    required this.iconAsset,
    this.onTap,
    this.backgroundColor = Colors.white,
    this.iconColor = AppColors.colorBlack,
    this.size = 36,
    this.iconSize = 20,
    this.padding = 8,
    this.elevation = .6,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: backgroundColor,
          shape: const CircleBorder(),
          elevation: elevation,
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: SizedBox(
                height: iconSize,
                width: iconSize,
                child: SvgPicture.asset(
                  iconAsset,
                  width: iconSize,
                  height: iconSize,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    iconColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (count != null && count! > 0)
          Positioned(
            top: 1,
            right: 2,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration:  BoxDecoration(
                color: AppColors.colorRed,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Center(
                child: AutoSizeText(
                  count! > 99 ? '99+' : '$count',
                  maxLines: 1,
                  minFontSize: 7,
                  maxFontSize: 10,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
