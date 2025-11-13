
// Custom widget implementation
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_max/core/ui/app_theme.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:recharge_max/core/utils/loaders.dart';

class SearchableCustomDropdownWidget<T> extends StatelessWidget {
  const SearchableCustomDropdownWidget({
    super.key,
    required this.items,
    this.selectedItems = const [],
    this.selectedItem,
    this.hintText,
    this.labelText,
    this.validator,
    this.onChanged,
    this.onChangedMultiSelection,
    this.searchEnabled = true,
    this.isMultiSelection = false,
    this.showLoader = false,
    this.clearButtonEnabled = true,
    this.maxHeight,
    this.itemAsString,
    this.compareFn,
    this.filterFn,
    this.hasNoBorder = false,
    this.containerBgColor,
    this.borderRadius,
    this.hasBorderLine = true,
    this.width,
    this.enabled = true,
    this.showSearchBox = true,
    this.searchFieldProps,
    this.popupProps,
    this.borderColor,
    this.borderWidth,
    this.isRequired = false,

    this.suffixIcon,
    this.prefixIcon,
    this.height,
    this.expands = false,
    this.hasFilled = true,
    this.readOnly = false, // Fixed typo
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction, // Added to constructor
    this.fillColor,
    this.onEditingComplete,
    this.onFieldSubmitted, // Added to constructor
    this.focusNode,
    this.contentPadding,
    this.labelSideWidget,
    this.suffix,
    this.prefix,
    this.autoValidateMode,
    this.labelSize
  });

  final List<T> items;
  final List<T> selectedItems;
  final T? selectedItem;
  final String? hintText;
  final String? labelText;
  final String? Function(T?)? validator;
  final Function(T?)? onChanged;
  final Function(List<T>)? onChangedMultiSelection;
  final bool searchEnabled;
  final bool isMultiSelection;
  final bool showLoader;
  final bool clearButtonEnabled;
  final double? maxHeight;
  final String Function(T)? itemAsString;
  final bool Function(T, T)? compareFn;
  final bool Function(T, String)? filterFn;
  final bool hasNoBorder;
  final Color? containerBgColor;
  final BorderRadius? borderRadius;
  final bool hasBorderLine;
  final double? width;
  final bool enabled;
  final bool showSearchBox, isRequired;
  final TextFieldProps? searchFieldProps;
  final PopupPropsMultiSelection<T>? popupProps;
  final Color? borderColor;
  final double? borderWidth;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final bool hasFilled;
  final double? height;
  final bool expands;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction; // New parameter for keypad action
  final Function(String value)?
  onFieldSubmitted; // New parameter for submit action
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final bool readOnly;
  final Widget? labelSideWidget;
  final AutovalidateMode? autoValidateMode;
  final double? labelSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Label and loader row
        if (labelText != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: RichText(
                  text: TextSpan(
                    text: labelText!,
                    style: TextStyle(
                      color: AppColors.colorBlack,
                      fontSize: labelSize?? 12.sp,
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

              if (showLoader) Loaders.circularLoader
            ],
          ),

        // if (labelText != null) const SizedBox(height: 8),

        // Dropdown widget
        Container(
          width: width,
          child: isMultiSelection
              ? _buildMultiSelectionDropdown(context)
              : _buildSingleSelectionDropdown(context),
        ),
      ],
    );
  }

  Widget _buildMultiSelectionDropdown(BuildContext context) {
    return DropdownSearch<T>.multiSelection(
      items: items,
      selectedItems: selectedItems,
      enabled: enabled && items.isNotEmpty,
      validator: (List<T>? value) {
        if (validator != null && value != null) {
          return validator!(value.isEmpty ? null : value.first);
        }
        return null;
      },
      onChanged: onChangedMultiSelection,
      dropdownDecoratorProps: _getDropdownDecoratorProps(context),
      popupProps: popupProps ?? _getMultiSelectionPopupProps(context),
      itemAsString: itemAsString,
      compareFn: compareFn,
      filterFn: filterFn,
    );
  }

  Widget _buildSingleSelectionDropdown(BuildContext context) {
    return DropdownSearch<T>(
      items: items,
      selectedItem: selectedItem,
      enabled: enabled && items.isNotEmpty,
      validator: validator,
      onChanged: onChanged,
      dropdownDecoratorProps: _getDropdownDecoratorProps(context),
      popupProps: _getSingleSelectionPopupProps(context),
      itemAsString: itemAsString,
      compareFn: compareFn,
      filterFn: filterFn,
    );
  }

  DropDownDecoratorProps _getDropdownDecoratorProps(BuildContext context) {
    return DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        hintText: hintText ??
            (labelText != null
                ? 'Enter your ${labelText?.toLowerCase()}'
                : ''),
        errorMaxLines: 3,
        errorStyle: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontFamily: AppTheme.geist,
          fontWeight: FontWeight.bold,
          fontSize: 12.sp,
        ),
        fillColor: fillColor ?? AppColors.colorWhite,
        filled: hasFilled,
        contentPadding: contentPadding ??
            const EdgeInsets.fromLTRB(16, 12, 16, 12).r,
        hintMaxLines: 5,
        hintStyle: TextStyle(
          color: AppColors.hintGrey,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          fontFamily: AppTheme.geist,
        ),
        enabled: enabled,
        border:  OutlineInputBorder(
          borderRadius:
          borderRadius ?? BorderRadius.circular(8).r,
          borderSide: BorderSide(
            color: borderColor ?? AppColors.colorPrimary,
            width: borderWidth ?? .1,
          ),
        ),
        focusedBorder:  OutlineInputBorder(
          borderRadius:
         borderRadius ?? BorderRadius.circular(8).r,
          borderSide: BorderSide(
            color: borderColor ?? AppColors.colorPrimary,
            width:borderWidth ?? .5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8).r,
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: .5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8).r,
          borderSide: BorderSide(
            color: borderColor ?? AppColors.colorTextFieldBorder,
            width: borderWidth ??  .5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8).r,
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 1.w,
          ),
        ),
        suffix: suffix,
        prefix: prefix,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8).r,
          borderSide: BorderSide(
            color:borderColor ??  AppColors.green250,
            // AppColors.colorTextFieldBorder,
            width: borderWidth ??  1,
          ),
        ),
        constraints: BoxConstraints(
          minHeight: 48.h,
          maxHeight: height ?? 100.h,
        ),
      ),
    );
  }

  PopupPropsMultiSelection<T> _getMultiSelectionPopupProps(BuildContext context) {
    return PopupPropsMultiSelection.menu(
      showSelectedItems: true,
      showSearchBox: searchEnabled && showSearchBox,
      searchFieldProps: searchFieldProps ??
          TextFieldProps(
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon:prefixIcon?? const Icon(Icons.search),

              errorMaxLines: 3,
              errorStyle: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontFamily: AppTheme.geist,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
              fillColor: fillColor ?? AppColors.colorWhite,
              filled: hasFilled,
              contentPadding: contentPadding ??
                  const EdgeInsets.fromLTRB(16, 12, 16, 12).r,
              hintMaxLines: 5,
              hintStyle: TextStyle(
                color: AppColors.hintGrey,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                fontFamily: AppTheme.geist,
              ),
              enabled: enabled,
              border:  OutlineInputBorder(
                borderRadius:
                borderRadius ?? BorderRadius.circular(8).r,
                borderSide: BorderSide(
                  color: borderColor ?? AppColors.colorPrimary,
                  width: borderWidth ?? .1,
                ),
              ),
              focusedBorder:  OutlineInputBorder(
                borderRadius:
                borderRadius ?? BorderRadius.circular(8).r,
                borderSide: BorderSide(
                  color: borderColor ?? AppColors.colorPrimary,
                  width:borderWidth ?? .5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8).r,
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: .5,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8).r,
                borderSide: BorderSide(
                  color: borderColor ?? AppColors.colorTextFieldBorder,
                  width: borderWidth ??  1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8).r,
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 1.w,
                ),
              ),
              suffix: suffix,
              prefix: prefix,
              suffixIcon: suffixIcon,
              enabledBorder: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8).r,
                borderSide: BorderSide(
                  color:borderColor ??  AppColors.green250,
                  // AppColors.colorTextFieldBorder,
                  width: borderWidth ??  1,
                ),
              ),
              constraints: BoxConstraints(
                minHeight: 48.h,
                maxHeight: height ?? 100.h,
              ),
            ),
          ),
      menuProps: MenuProps(
        borderRadius: BorderRadius.circular(12),
        elevation: 8,
        backgroundColor: Colors.white,
      ),
      constraints: BoxConstraints(
        maxHeight: maxHeight ?? 300,
      ),
      selectionWidget: (context, item, isSelected) {
        return Checkbox(
          value: isSelected,
          onChanged: (_) {},
          activeColor: Colors.green,
        );
      },
      itemBuilder: (context, item, isSelected) {
        return ListTile(
          title: Text(
            itemAsString != null ? itemAsString!(item) : item.toString(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: isSelected
              ? const Icon(
            Icons.check_circle_outline,
            color: Colors.green,
          )
              : null,
        );
      },
      emptyBuilder: (context, searchEntry) => const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('No items found'),
        ),
      ),
    );
  }

  PopupProps<T> _getSingleSelectionPopupProps(BuildContext context) {
    return PopupProps.menu(
      showSelectedItems: true,
      showSearchBox: searchEnabled && showSearchBox,
      searchFieldProps: searchFieldProps ??
          TextFieldProps(
            decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon:prefixIcon?? const Icon(Icons.search),

            errorMaxLines: 3,
            errorStyle: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontFamily: AppTheme.geist,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
            fillColor: fillColor ?? AppColors.colorWhite,
            filled: hasFilled,
            contentPadding: contentPadding ??
                const EdgeInsets.fromLTRB(16, 12, 16, 12).r,
            hintMaxLines: 5,
            hintStyle: TextStyle(
              color: AppColors.hintGrey,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              fontFamily: AppTheme.geist,
            ),
            enabled: enabled,
            border:  OutlineInputBorder(
              borderRadius:
              borderRadius ?? BorderRadius.circular(8).r,
              borderSide: BorderSide(
                color: borderColor ?? AppColors.colorPrimary,
                width: borderWidth ?? .1,
              ),
            ),
            focusedBorder:  OutlineInputBorder(
              borderRadius:
              borderRadius ?? BorderRadius.circular(8).r,
              borderSide: BorderSide(
                color: borderColor ?? AppColors.colorPrimary,
                width:borderWidth ?? .5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(8).r,
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: .5,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(8).r,
              borderSide: BorderSide(
                color: borderColor ?? AppColors.colorTextFieldBorder,
                width: borderWidth ??  1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(8).r,
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 1.w,
              ),
            ),
            suffix: suffix,
            prefix: prefix,
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(8).r,
              borderSide: BorderSide(
                color:borderColor ??  AppColors.green250,
                // AppColors.colorTextFieldBorder,
                width: borderWidth ??  1,
              ),
            ),
            constraints: BoxConstraints(
              minHeight: 48.h,
              maxHeight: height ?? 100.h,
            ),
          ),
          ),
      menuProps: MenuProps(
        borderRadius: BorderRadius.circular(12),
        elevation: 8,
        backgroundColor: Colors.white,
      ),
      constraints: BoxConstraints(
        maxHeight: maxHeight ?? 300,
      ),
      itemBuilder: (context, item, isSelected) {
        return ListTile(
          title: Text(
            itemAsString != null ? itemAsString!(item) : item.toString(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: isSelected
              ? const Icon(
            Icons.check_circle_outline,
            color: Colors.green,
          )
              : null,
        );
      },
      emptyBuilder: (context, searchEntry) => const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('No items found'),
        ),
      ),
    );
  }
}