import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recharge_max/core/ui/colors.dart';



class IconTitleDescTextWidget extends StatelessWidget {
  final String iconPath; // Path to the SVG icon
  final String labelText; // The label (e.g., "Dimensions")
  final String valueText; // The value (e.g., "32.5cm X 45cm X 70cm")
  final TextStyle? textStyle; // Custom text style for the label text
  final TextStyle? valueTextStyle; // Custom text style for the value text

  const IconTitleDescTextWidget({
    required this.iconPath,
    required this.labelText,
    required this.valueText,
    this.textStyle,
    this.valueTextStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Default text style if not provided for label
    TextStyle defaultTextStyle = const TextStyle(
      color: AppColors.black100,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );

    // Default text style if not provided for value
    TextStyle defaultValueTextStyle = TextStyle(
      color: AppColors.grey50,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );

    // Use custom styles or fallback to default
    TextStyle effectiveTextStyle = textStyle ?? defaultTextStyle;
    TextStyle effectiveValueTextStyle = valueTextStyle ?? defaultValueTextStyle;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 16.0, // You can adjust the size here
            height: 16.0, // You can adjust the size here
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(
              AppColors.black100 ,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 8), // Spacing between icon and text
          RichText(
            text: TextSpan(
              text: '$labelText:', // The label text
              style: effectiveTextStyle,
              children: [
                TextSpan(
                  text: ' $valueText', // The value text
                  style: effectiveValueTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}