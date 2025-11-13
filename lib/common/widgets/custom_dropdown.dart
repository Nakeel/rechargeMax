import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_max/core/ui/app_theme.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:recharge_max/core/utils/loaders.dart';
import 'package:recharge_max/core/utils/size.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.selectedItem,
    required this.dropDownList,
    this.hintText,
    this.onValueChanged,
    this.height,
    this.width,
    this.hintWidget,
    this.valueWidget,
    this.hasNoBorder = false,
    this.isEnabled = true,
    this.selectedItemBuilder,
    this.iconEnabledColor,
    this.hintStyle,
    this.textStyle,
    this.iconSize = 20,
    this.containerBgColor,
    this.borderRadius = 10,
    this.isValidated = false,
    this.hasBorderLine = true,
    this.isOutlineIcon = false,
    this.showLoader = false,
    this.isRequired = false,
    this.labelText,
  });

  final dynamic selectedItem;
  final List<dynamic> dropDownList;
  final ValueChanged<dynamic>? onValueChanged;
  final double? height, width, iconSize, borderRadius;
  final String? hintText, labelText;
  final Widget? hintWidget;
  final Function(dynamic)? valueWidget;
  final bool hasNoBorder,
      isEnabled,
      isValidated,
      hasBorderLine,
      isOutlineIcon,
      isRequired,
      showLoader;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Color? iconEnabledColor, containerBgColor;
  final TextStyle? hintStyle, textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (labelText != null) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: RichText(
                  text: TextSpan(
                    text: '$labelText',
                    style: TextStyle(
                      color: AppColors.colorBlack,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppTheme.geist,
                    ),
                    children: isRequired
                        ? [
                            const TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]
                        : [],
                  ),
                ),
              ),
            ],
            if (showLoader) Loaders.circularLoader
          ],
        ),
        if (labelText != null) S.h(8.h),
        Container(
          height: height ?? 50,
          width: width,
          decoration: hasNoBorder
              ? null
              : BoxDecoration(
                  color: containerBgColor ?? Colors.white,
                  borderRadius: BorderRadius.circular(borderRadius!),
                  border: hasBorderLine
                      ? Border.all(
                          width: .5,
                          color: isValidated
                              ? const Color(0xFF444648)
                              : AppColors.green250,
                        )
                      : null,
                ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<dynamic>(
              isExpanded: true,
              value: selectedItem,
              hint: hintWidget ??
                  Text(hintText ?? 'Select',
                      style: hintStyle ??
                          TextStyle(
                            color: AppColors.colorGrey,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: AppTheme.geist,
                          )),
              icon: Icon(
                Icons.keyboard_arrow_down,
                size: iconSize,
                color: isEnabled
                    ? iconEnabledColor
                    : iconEnabledColor?.withOpacity(0.3),
              ),
              underline: const SizedBox(),
              items: dropDownList.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: valueWidget != null
                      ? valueWidget!(value)
                      : Text(value.toString(),
                          style: textStyle ??
                              TextStyle(
                                color: AppColors.colorBlack,
                                fontSize: 14.sp,
                                fontFamily: AppTheme.geist,
                                fontWeight: FontWeight.w400,
                                height: 1.9.h,
                              )),
                );
              }).toList(),
              dropdownColor: Colors.white,
              selectedItemBuilder: selectedItemBuilder,
              borderRadius: BorderRadius.circular(20),
              onChanged: isEnabled ? onValueChanged : null,
              menuMaxHeight: MediaQuery.of(context).size.height *
                  0.5, // Set a max height for the dropdown.
            ),
          ),
        ),
      ],
    );
  }
}
