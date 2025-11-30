import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:recharge_max/core/utils/size.dart';

import '../../core/ui/app_theme.dart';
import 'app_text.dart';

class AppButton {
  static Widget fill({
    required BuildContext context,
    Size? size,
    required String text,
    bool disabled = false,
    Color? backgroundColor,
    Color? textColor,
    BorderRadiusGeometry? borderRadius,
    bool loading = false,
    Widget? preffixIcon,
    Widget? suffixIcon,
    FontWeight? fontWeight,
    double? fontSize,
    required void Function()? onPressed,
  }) {
    return AbsorbPointer(
      absorbing: disabled || loading,
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: (disabled
                    ? backgroundColor?.withOpacity(.5)
                    : backgroundColor) ??
                (disabled ? AppColors.disabledColor : AppColors.colorPrimary),
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(12),
            ),
            minimumSize: size ?? Size(0.w, 48.h),
            textStyle: TextStyle(
              color: disabled
                  ? AppColors.colorGrey
                  : (textColor ?? AppColors.colorWhite),
              fontSize: fontSize ?? 16.sp,
              fontFamily: AppTheme.opensans,
              fontWeight: fontWeight ?? FontWeight.w600,
            ),
            // foregroundColor: textColor ?? AppColors.colorWhite,
          ),
          onPressed: onPressed == null
              ? null
              : () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  onPressed();
                },
          child: loading
              ? SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(
                      disabled ? AppColors.colorPrimary : AppColors.colorWhite,
                    ),
                  ),
                )
              : FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      if (preffixIcon != null) ...[
                        S.w(12),
                        preffixIcon,
                      ],
                      TextView(
                        text: text,
                        textAlign: TextAlign.center,
                        color: disabled
                            ? (textColor ?? AppColors.colorPrimary).withOpacity(.4)
                            : (textColor ?? AppColors.colorWhite),
                        fontSize: fontSize ?? 16.sp,

                        fontWeight: fontWeight ?? FontWeight.w600,
                        // style: Theme.of(context).textTheme.titleLarge,
                      ),
                      if (suffixIcon != null) ...[
                        suffixIcon,
                      ]
                    ],
                  ),
                )),
    );
  }

  static Widget small({
    required BuildContext context,
    Size? size,
    required String text,
    bool disabled = false,
    Color? backgroundColor,
    Color? textColor,
    BorderRadiusGeometry? borderRadius,
    bool loading = false,
    Widget? preffixIcon,
    Widget? suffixIcon,
    FontWeight? fontWeight,
    double? fontSize,
    required void Function()? onPressed,
  }) {
    return AbsorbPointer(
      absorbing: disabled || loading,
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: (disabled
                    ? backgroundColor?.withOpacity(.5)
                    : backgroundColor) ??
                (disabled
                    ? AppColors.disabledColor
                    : Theme.of(context).primaryColor),
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(12),
            ),
            minimumSize: size ?? Size(100.w, 10.h),
            textStyle: TextStyle(
              color: disabled
                  ? const Color(0xff868685)
                  : (textColor ?? AppColors.colorWhite),
              fontSize: fontSize ?? 10.sp,
              fontFamily: AppTheme.opensans,
              fontWeight: fontWeight ?? FontWeight.w400,
            ),
            // foregroundColor: textColor ?? AppColors.colorWhite,
          ),
          onPressed: onPressed == null
              ? null
              : () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  onPressed();
                },
          child: loading
              ? SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(
                      disabled
                          ? Theme.of(context).primaryColor
                          : AppColors.colorWhite,
                    ),
                  ),
                )
              : FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      if (preffixIcon != null) ...[
                        S.w(12),
                        preffixIcon,
                      ],
                      TextView(
                        text: text,
                        textAlign: TextAlign.center,
                        color: disabled
                            ? (textColor ?? AppColors.colorPrimary).withOpacity(.4)
                            : (textColor ?? AppColors.colorWhite),
                        fontSize: fontSize ?? 12.sp,

                        fontWeight: fontWeight ?? FontWeight.w600,
                        // style: Theme.of(context).textTheme.titleLarge,
                      ),
                      if (suffixIcon != null) ...[
                        suffixIcon,
                      ]
                    ],
                  ),
                )),
    );
  }

  static Widget outlined(
      {required BuildContext context,
      Size? size,
      required String text,
      bool disabled = false,
        bool isLoading = false,
      Color? borderColor,
      Color? textColor,
      FontWeight? fontWeight,
      Widget? preffixIcon,
      Widget? suffixIcon,
      double? fontSize,
      BorderRadius? radius,
      EdgeInsets? suffixMargin,
      EdgeInsets? preffixMargin,
      required void Function()? onPressed}) {
    return AbsorbPointer(
      absorbing: disabled,
      child: OutlinedButton(
          style: TextButton.styleFrom(
              backgroundColor: disabled ? AppColors.disabledColor : null,
              side: BorderSide(
                color: borderColor ?? Theme.of(context).primaryColor,
                width: 0.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: radius ?? BorderRadius.circular(4),
              ),
              minimumSize: size ?? Size(0.w, 48.h),
              textStyle: TextStyle(
                color: disabled
                    ? AppColors.colorGrey
                    : textColor ?? Theme.of(context).primaryColor,
                fontSize: fontSize ?? 14.sp,
                fontFamily: AppTheme.opensans,
                fontWeight: fontWeight ?? FontWeight.w400,
              ),
              foregroundColor: borderColor != null
                  ? borderColor.withAlpha(40)
                  : Theme.of(context).primaryColor),
          onPressed: onPressed,
          child: isLoading ? SizedBox(
        width: 20.w,
        height: 20.h,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(
            disabled ? AppColors.colorPrimary
                : (borderColor??AppColors.colorPrimary).withOpacity(.7),
          ),
        ),
      ) :Row(
            mainAxisAlignment: (preffixIcon == null && suffixIcon == null)
                ? MainAxisAlignment.center
                : MainAxisAlignment.center,
            children: [
              // if (preffixIcon != null) ...[
              //   S.w(12),
              //   preffixIcon,
              // ],
              if (preffixIcon != null)
                Container(
                  width: S.rW(context, .1),
                  margin: preffixMargin ?? const EdgeInsets.only(right: 15).r,
                  child: preffixIcon,
                ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: TextView(
                  text: text,
                  textAlign: TextAlign.center,
                  fontSize: fontSize ?? 16.sp,
                  color: disabled
                      ? AppColors.disabledColor
                      : textColor ?? Theme.of(context).primaryColor,
                  fontWeight: fontWeight ?? FontWeight.w500,
                  // style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              if (suffixIcon != null)
                Container(
                  width: S.rW(context, .1),
                  margin: suffixMargin ?? const EdgeInsets.only(left: 15).r,
                  child: suffixIcon,
                ),
            ],
          )),
    );
  }
}
