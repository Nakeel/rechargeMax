import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:dio/dio.dart';
import 'package:recharge_max/core/network/env.dart';
import 'package:recharge_max/core/ui/app_theme.dart';
import 'package:recharge_max/core/ui/assets.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:recharge_max/core/utils/app_logger.dart';
import 'package:uuid/uuid.dart';

class AddressAutocompleteWidget extends StatefulWidget {
  final Function(String) onAddressSelected;
  final Function()? onUseCurrentLocation;
  final Function()? onManualEntry;
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
  final Color? borderColor;
  final double? borderWidth;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final bool readOnly;
  final Widget? labelSideWidget;
  final BorderRadius? borderRadius;
  final AutovalidateMode? autoValidateMode;
  final double? labelSize;
  final bool removeBottomSpace;

  const AddressAutocompleteWidget({
    Key? key,
    required this.onAddressSelected,
    this.onUseCurrentLocation,
    this.onManualEntry,
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
    this.removeBottomSpace =false,
    this.labelSize
  }) : super(key: key);

  @override
  State<AddressAutocompleteWidget> createState() =>
      _AddressAutocompleteWidgetState();
}

class _AddressAutocompleteWidgetState extends State<AddressAutocompleteWidget> {
  final Dio _dio = Dio();
  late TextEditingController _controller;
  late FocusNode _focusNode;
  List<Map<String, String>>? places ;
  final String sessionToken = Uuid().v4();

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      setState(() {});
    });

    _controller = widget.controller ?? TextEditingController();
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

  Future<List<Map<String, String>>> _getSuggestions(String query) async {
    if (query.isEmpty) return [];

    final googleApiKey = Env.getConfig.mapApiKey;
    if (googleApiKey == null || googleApiKey.isEmpty) {
      AppLogger.error('Google API key is missing or invalid');
      return [];
    }

    try {
      // URL-encode the query to handle special characters
      final encodedQuery = Uri.encodeComponent(query);
      final url =
          "https://places.googleapis.com/v1/places:autocomplete";
          // "$googleApiKey";

      AppLogger.info('Requesting URL: $url');
      final response = await _dio.post(
        url,data: {
        'input': query,
        'sessionToken': sessionToken,
        "regionCode": "NG",
      },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'X-Goog-FieldMask': 'suggestions.placePrediction.placeId,suggestions.placePrediction.text.text',
            // Include X-Goog-Api-Key header as required by the new Places API
            'X-Goog-Api-Key': googleApiKey,
          },
        ),
      );

      AppLogger.info('Response status: ${response.statusCode}');
      AppLogger.info('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;
        final suggestions = data['suggestions'] as List<dynamic>? ?? [];
        List<Map<String, String>> places = suggestions.map((s) {
          return {
            'id': (s['placePrediction']['placeId'] ?? '').toString(),
            'description': (s['placePrediction']['text']['text'] ?? '').toString(),
          };
        }).toList();
        return places;
      } else {
        AppLogger.error('Places API error: Status ${response.statusCode}, Body: ${response.data}');
        return [];
      }
    } catch (e, stackTrace) {
      AppLogger.error('Places API exception: $e', stackTrace: stackTrace);
      return [];
    }
  }


  Widget _buildSuggestionContainer(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey400),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }

  Widget _buildUseCurrentLocation() {
    return GestureDetector(
      onTap: widget.onUseCurrentLocation,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.grey150)),
        ),
        child: Row(
          children: [
            SvgPicture.asset(Assets.navigationArrow),
            const SizedBox(width: 10),
            const Text(
              'Use Current Location',
              style: TextStyle(
                color: AppColors.colorPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManualEntry() {
    return GestureDetector(
      onTap: widget.onManualEntry,
      child: Container(
        height: 44,
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: AppColors.itemGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: const Text(
          'Can’t find your address? Tap here to add manually',
          style: TextStyle(fontSize: 13),
        ),
      ),
    );
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
                      color: AppColors.colorBlack,
                      fontSize: widget.labelSize ?? 12.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppTheme.geist,
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

        TypeAheadField<Map<String, String>>(
          debounceDuration: const Duration(milliseconds: 600),
          builder: (context, controller, focusNode) {
            return TextField(
                controller: controller,
                focusNode: focusNode,
                onChanged: widget.onChanged,
                style: TextStyle(
                  color: AppColors.colorBlack,
                  fontSize: 14.sp,
                  fontFamily: AppTheme.geist,
                  fontWeight: FontWeight.w400,
                  height: 1.9.h,
                ),
                decoration: InputDecoration(
                  hintText: widget.hint ?? 'Start typing your address...',
                  errorMaxLines: 3,
                  errorStyle: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontFamily: AppTheme.geist,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                  fillColor: widget.fillColor ?? AppColors.colorWhite,
                  filled: widget.hasFilled,
                  contentPadding: widget.contentPadding ??
                      const EdgeInsets.fromLTRB(16, 12, 16, 12).r,
                  hintMaxLines: 5,
                  hintStyle: TextStyle(
                    color: AppColors.hintGrey,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppTheme.geist,
                  ),
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
                  focusedBorder:  OutlineInputBorder(
                    borderRadius:
                    widget.borderRadius ?? BorderRadius.circular(8).r,
                    borderSide: BorderSide(
                      color: widget.borderColor ?? AppColors.colorPrimary,
                      width: widget.borderWidth ?? .5,
                    ),
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
                    borderSide: BorderSide(
                      color: widget.borderColor ?? AppColors.colorTextFieldBorder,
                      width: widget.borderWidth ?? (_controller.text.isEmpty ? 1 : 0),
                    ),
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
                  // Icon(Icons.search_outlined,  color: AppColors.black100,),
                  suffixIcon:  widget.suffixIcon ,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: widget.borderRadius ?? BorderRadius.circular(8).r,
                    borderSide: BorderSide(
                      color: widget.borderColor ??  AppColors.green250,
                      // AppColors.colorTextFieldBorder,
                      width: widget.borderWidth ?? (_controller.text.isEmpty ? 1 : 0),
                    ),
                  ),
                  constraints: BoxConstraints(
                    minHeight: 48.h,
                    maxHeight: widget.height ?? 100.h,
                  ),
                ));
          },
          controller: _controller,
          emptyBuilder: (context) {
            return _buildSuggestionContainer([
              _buildUseCurrentLocation(),
               Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'No match found',
                  style: TextStyle(color: AppColors.grey300),
                ),
              ),
              _buildManualEntry(),
            ]);
          },
          errorBuilder: (context, error) {
            return _buildSuggestionContainer([
              _buildUseCurrentLocation(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'Error fetching suggestions',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              _buildManualEntry(),
            ]);
          },
          suggestionsCallback: (pattern) async {
            return await _getSuggestions(pattern);
          },

          itemBuilder: (context, suggestion) => ListTile(
            leading:SvgPicture.asset(
              Assets.map,
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor,
                BlendMode.srcIn,
              ),
            ),
            title: Text(
              suggestion["description"]!,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          onSelected: (Map<String, String> value) {
            _controller.text = value["description"]!;
            widget.onAddressSelected(value["description"]!);
          },
        ),
      ],
    );
  }
}
