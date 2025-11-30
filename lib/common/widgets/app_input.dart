import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_max/core/ui/app_theme.dart';
import 'package:recharge_max/core/ui/colors.dart';

class AppTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final bool obscure, hasFilled;
  final double? height;
  final bool isRequired;
  final bool enabled;
  final bool expands;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction; // New parameter for keypad action
  final TextEditingController? controller;
  final Function(String value)? onChanged;
  final Function()? onTap;
  final Function(String value)?
      onFieldSubmitted; // New parameter for submit action
  final String? Function(String? value)? validator;
  final Color? fillColor;
  final Color? labelColor;
  final Color? borderColor;
  final double? borderWidth;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final bool readOnly; // Fixed typo: reradOnly -> readOnly
  final Widget? labelSideWidget;
  final BorderRadius? borderRadius;
  final AutovalidateMode? autoValidateMode;
  final double? labelSize;
  final bool removeBottomSpace;

  const AppTextField(
      {super.key,
      this.label,
      this.suffixIcon,
      this.prefixIcon,
      this.obscure = false,
      this.height,
      this.controller,
      this.validator,
      this.expands = false,
      this.hasFilled = true,
      this.readOnly = false, // Fixed typo
      this.maxLines = 1,
      this.enabled = true,
      this.keyboardType,
      this.textInputAction, // Added to constructor
      this.onChanged,
      this.borderColor,
      this.borderWidth,
      this.inputFormatters,
      this.isRequired = false,
      this.hint,
      this.onTap,
      this.fillColor,
      this.onEditingComplete,
      this.onFieldSubmitted, // Added to constructor
      this.focusNode,
      this.contentPadding,
      this.borderRadius,
      this.labelSideWidget,
      this.suffix,
      this.prefix,
      this.autoValidateMode,
      this.removeBottomSpace = false,
      this.labelSize,
      this.labelColor});

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController _controller;
  bool obscure = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      setState(() {});
    });

    _controller = widget.controller ?? TextEditingController();
    obscure = widget.obscure;
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose(); // Only dispose if not provided externally
    }
    if (widget.controller == null) {
      _controller.dispose(); // Only dispose if not provided externally
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.label != null) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: RichText(
                  text: TextSpan(
                    text: widget.label!,
                    style: TextStyle(
                      color: widget.labelColor ?? AppColors.colorBlack,
                      fontSize: widget.labelSize ?? 12.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppTheme.opensans,
                    ),
                    children: widget.isRequired
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
            if (widget.labelSideWidget != null) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: widget.labelSideWidget!,
              ),
            ],
          ],
        ),
        TextFormField(
          onTap: widget.onTap,
          obscureText: obscure,
          focusNode: _focusNode,
          controller: _controller,
          autovalidateMode: widget.autoValidateMode,
          validator: widget.validator,
          expands: widget.expands,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onFieldSubmitted, // Added onFieldSubmitted
          textInputAction: widget.textInputAction ??
              TextInputAction.done, // Added textInputAction
          minLines: null,
          maxLines: widget.expands ? null : widget.maxLines,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          readOnly: widget.readOnly, // Fixed typo
          inputFormatters: widget.inputFormatters,
          style: TextStyle(
            color: AppColors.colorBlack,
            fontSize: 14.sp,
            fontFamily: AppTheme.opensans,
            fontWeight: FontWeight.w400,
            height: 1.9.h,
          ),
          cursorWidth: 1.w,
          cursorHeight: 19.h,
          decoration: InputDecoration(
            alignLabelWithHint: widget.expands,
            hintText: widget.hint ??
                (widget.label != null
                    ? 'Enter your ${widget.label?.toLowerCase()}'
                    : ''),
            errorMaxLines: 3,
            errorStyle: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontFamily: AppTheme.opensans,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
            fillColor: widget.fillColor ?? AppColors.dividerGreen,
            filled: widget.hasFilled,
            contentPadding: widget.contentPadding ??
                const EdgeInsets.fromLTRB(16, 12, 16, 12).r,
            hintMaxLines: 5,
            hintStyle: TextStyle(
              color: AppColors.hintGrey,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              fontFamily: AppTheme.opensans,
            ),
            enabled: widget.enabled,
            border: _controller.text.isEmpty
                ? OutlineInputBorder(
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(8).r,
                    borderSide: BorderSide(
                      color: widget.borderColor ?? AppColors.colorPrimary,
                      width: widget.borderWidth ?? .1,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(4).r,
                    borderSide: BorderSide.none,
                  ),
            focusedBorder: _focusNode.hasFocus
                ? OutlineInputBorder(
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(8).r,
                    borderSide: BorderSide(
                      color: widget.borderColor ?? AppColors.colorPrimary,
                      width: widget.borderWidth ?? .5,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(8).r,
                    borderSide: BorderSide.none,
                  ),
            errorBorder: OutlineInputBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(8).r,
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: .5,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(8).r,
              borderSide: widget.enabled ?BorderSide(
                color: widget.borderColor ?? AppColors.colorTextFieldBorder,
                width: widget.borderWidth ?? (_controller.text.isEmpty ? 1 : 0),
              ): BorderSide.none,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(8).r,
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 1.w,
              ),
            ),
            suffix: widget.suffix,
            prefix: widget.prefix,
            prefixIcon: widget.prefixIcon,
            suffixIcon: !widget.obscure
                ? widget.suffixIcon
                : (obscure
                    ? IconButton(
                        onPressed: () {
                          obscure = !obscure;
                          setState(() {});
                        },
                        iconSize: 20,
                        color: AppColors.colorGrey,
                        icon: const Icon(Icons.visibility_off_outlined),
                      )
                    : IconButton(
                        onPressed: () {
                          obscure = !obscure;
                          setState(() {});
                        },
                        iconSize: 20,
                        color: AppColors.colorGrey,
                        icon: const Icon(Icons.visibility_outlined),
                      )),
            enabledBorder: OutlineInputBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(8).r,
              borderSide: BorderSide(
                color: widget.borderColor ?? AppColors.green250,
                // AppColors.colorTextFieldBorder,
                width: widget.borderWidth ?? (_controller.text.isEmpty ? 1 : 0),
              ),
            ),
            constraints: BoxConstraints(
              minHeight: 48.h,
              maxHeight: widget.height ?? 100.h,
            ),
          ),
        ),
        if (!widget.removeBottomSpace) const SizedBox(height: 12),
      ],
    );
  }
}
