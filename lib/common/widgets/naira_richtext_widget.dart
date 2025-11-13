import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

/// Reusable rich‑text widget that shows the Naira symbol plus a value.
/// ─────────────────────────────────────────────────────────────────────────────
/// • ₦ is forced to Roboto so it renders on every device.
/// • Value text inherits the app’s current font (e.g. Geist) unless overridden.
/// • Uses AutoSizeText to shrink text if it would overflow.
class NairaRichText extends StatelessWidget {
  /// Text (or number already formatted as text) that follows the ₦ symbol.
  final String value;

  /// Optional style override for just the ₦ symbol.
  final TextStyle? symbolStyle;

  /// Optional style override for the value text.
  final TextStyle? valueStyle;

  /// Typical AutoSizeText options you might want to expose.
  final TextAlign textAlign;
  final double minFontSize;
  final double stepGranularity;
  final int maxLines;

  const NairaRichText({
    super.key,
    required this.value,
    this.symbolStyle,
    this.valueStyle,
    this.textAlign = TextAlign.start,
    this.minFontSize = 8,
    this.stepGranularity = 0.5,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).textTheme.bodyLarge;

    // Style for the ₦ symbol – force Roboto, fall back to default size/color.
    final defaultSymbolStyle = base?.copyWith(
      fontFamily: 'Roboto',
    );

    // Style for the value – inherit current font (Geist or whatever).
    final defaultValueStyle = base;

    return AutoSizeText.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '\u20A6', // ₦
            style: defaultSymbolStyle?.merge(symbolStyle),
          ),
          TextSpan(
            text: value,
            style: defaultValueStyle?.merge(valueStyle),
          ),
        ],
      ),
      textAlign: textAlign,
      minFontSize: minFontSize,
      stepGranularity: stepGranularity,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
