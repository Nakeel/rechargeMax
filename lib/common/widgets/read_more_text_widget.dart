import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:recharge_max/core/utils/util.dart';

class ReadMoreTextWidget extends StatefulWidget {
  final String content;
  final double truncatePercentage;
  final TextStyle? textStyle; // Optional custom text style for the main text
  final TextStyle? readMoreStyle; // Optional custom style for "Read More" text
  const ReadMoreTextWidget({
    required this.content,
    this.truncatePercentage = 0.3, // Default to 30% truncation
    this.textStyle, // Optional
    this.readMoreStyle, // Optional
    super.key,
  });

  @override
   _ReadMoreTextWidgetState createState() => _ReadMoreTextWidgetState();

}

class _ReadMoreTextWidgetState extends State<ReadMoreTextWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // Default TextStyle
    TextStyle defaultTextStyle =   TextStyle(
      color: AppColors.grey50,
      fontSize: 14,
      fontWeight: FontWeight.w400
    );

    // Default Read More TextStyle
    TextStyle defaultReadMoreStyle = const TextStyle(
        color: AppColors.colorPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w600
    );

    // Use passed styles or fallback to defaults
    TextStyle textStyle = widget.textStyle ?? defaultTextStyle;
    TextStyle readMoreStyle = widget.readMoreStyle ?? defaultReadMoreStyle;

    String displayedText = _isExpanded
        ? widget.content
        : StringUtilities.getTruncatedContent(widget.content, percent: widget.truncatePercentage);

    return RichText(
      text: TextSpan(
        text: displayedText,
        style: textStyle,
        children: [
            TextSpan(
              text: _isExpanded ? ' See less' : ' Read More',
              style: readMoreStyle, // Use the custom or default style for "Read More"
              recognizer: TapGestureRecognizer()..onTap = _toggleExpandedState,
            ),
        ],
      ),
    );
  }

  void _toggleExpandedState() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
}
