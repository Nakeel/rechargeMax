import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_max/core/ui/app_theme.dart';
import 'package:recharge_max/core/ui/colors.dart';

class TextView extends StatelessWidget {
  final String text;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final Color? color;
  final double? fontSize;
  final double? letterSpacing;
  final double? lineHeight;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Function()? onTap;
  final int? maxLines;
  final TextStyle? textStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final List<Shadow>? shadows;
  final String? fontFamily;

  const TextView({
    Key? key,
    required this.text,
    this.textOverflow = TextOverflow.clip,
    this.textAlign = TextAlign.left,
    this.color,
    this.onTap,
    this.fontSize,
    this.letterSpacing,
    this.lineHeight,
    this.textStyle,
    this.maxLines,
    this.fontWeight = FontWeight.w400,
    this.decoration,
    this.decorationStyle,
    this.shadows,
    this.decorationThickness,
    this.decorationColor,
    this.fontFamily,
    this.fontStyle = FontStyle.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: textStyle ??
            TextStyle(
              color: color ?? AppColors.colorBlack,
              shadows: shadows,
              decoration: decoration,
              decorationStyle: decorationStyle,
              decorationThickness: decorationThickness,
              decorationColor: decorationColor,
              fontWeight: fontWeight,
              fontSize: fontSize ?? 16.sp,
              fontStyle: fontStyle,
              fontFamily: fontFamily ?? AppTheme.geist,
              letterSpacing: letterSpacing,
              height: lineHeight,
            ),
        textAlign: textAlign,
        overflow: textOverflow,
        maxLines: maxLines,
        softWrap: true,
      ),
    );
  }
}
