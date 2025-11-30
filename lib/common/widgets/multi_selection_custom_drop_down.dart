
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:recharge_max/common/models/drop_down_model.dart';
import 'package:recharge_max/core/ui/app_theme.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:recharge_max/core/utils/loaders.dart';
import 'package:recharge_max/core/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';


class MultiSelectionDropdownWidget<T> extends StatelessWidget {
  const MultiSelectionDropdownWidget({
    super.key,
    required this.items,
    this.controller,
    this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.label,
    this.labelText,
    this.searchEnabled = false,
    this.onSelectionChange,
    this.hasNoBorder = false,
    this.containerBgColor,
    this.borderRadius = 10,
    this.isValidated = false,
    this.hasBorderLine = true,
    this.singleSelect = true,
    this.selectedItems = const [],
    this.showLoader = false,
    this.onRemoved,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.maxSelections = 0,
  });

  final List<DropdownItem<DropDownOption>> items;
  final MultiSelectController<DropDownOption>? controller;
  final String? hintText;
  final String? Function(List<DropdownItem<DropDownOption>>?)? validator;
  final TextInputType keyboardType;
  final Widget? label;
  final String? labelText;
  final bool searchEnabled;
  final void Function(List<DropDownOption>)? onSelectionChange;
  final bool hasNoBorder, isValidated, hasBorderLine, singleSelect;
  final Color? containerBgColor;
  final double? borderRadius;
  final List<DropdownItem<DropDownOption>> selectedItems;
  final void Function(int index, DropdownItem<T> option)? onRemoved;
  final bool showLoader;
  final bool enabled;
  final AutovalidateMode autovalidateMode;
  final int maxSelections;

  @override
  Widget build(BuildContext context) {
    final effectiveController = controller ?? MultiSelectController<DropDownOption>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (labelText != null)
              Text(
                '${labelText}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.colorBlack,
                  fontWeight: FontWeight.w500,
                ),
              ),
            if (showLoader)
              Loaders.circularLoader
          ],
        ),
        if (labelText != null)
          S.h(8.h),
        MultiDropdown<DropDownOption>(
          key: key,
          controller: effectiveController,
          items: items,
          enabled: enabled,
          singleSelect: singleSelect,
          searchEnabled: searchEnabled,
          autovalidateMode: autovalidateMode,
          maxSelections: maxSelections,
          validator: validator,
          searchDecoration: SearchFieldDecoration(
              border: hasNoBorder
                  ? InputBorder.none
                  : OutlineInputBorder(
                borderSide: hasBorderLine
                    ?  BorderSide(color: AppColors.colorTextFieldBorder, width: .5 )
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
              ),
            searchIcon: Icon(Icons.search, color: AppColors.colorTextFieldBorder,)
          ),
          onSelectionChange: onSelectionChange,
          chipDecoration: ChipDecoration(
            labelStyle: const TextStyle(fontSize: 13),
            backgroundColor: containerBgColor ?? Colors.grey.shade200,
          ),
          fieldDecoration: FieldDecoration(
            border: hasNoBorder
                ? InputBorder.none
                : OutlineInputBorder(
              borderSide: hasBorderLine
                  ?  BorderSide(color: AppColors.colorTextFieldBorder, width: .5 )
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
            ),
            hintText: hintText ?? 'Select',
            showClearIcon: false,
            hintStyle:  TextStyle(
              color: AppColors.colorGrey,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              fontFamily: AppTheme.opensans,
            )
          ),
        ),
      ],
    );
  }
}

