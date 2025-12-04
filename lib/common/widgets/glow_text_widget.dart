import 'package:flutter/material.dart';
import 'package:recharge_max/core/ui/app_theme.dart';

class GlowTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fillColor;
  final Color outlineColor;
  final double outlineWidth;
  final double shadowBlur;
  final Color shadowColor;
  // final String fontFamily;

  const GlowTextWidget({
    super.key,
    required this.text,
    this.fontSize = 34,
    this.fontWeight = FontWeight.w900,
    this.fillColor = const Color(0xFF1E88E5),   // Blue
    this.outlineColor = Colors.white,
    this.outlineWidth = 6,
    this.shadowBlur = 20,
    // this.fontFamily =  'Roboto' ,
    this.shadowColor = const Color(0xFFFFF59D), // Yellow glow
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // --- Glow Shadow ---
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            // fontFamily: fontFamily,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = outlineWidth
              ..color = outlineColor,
            shadows: [
              Shadow(
                color: shadowColor.withOpacity(.8),
                blurRadius: shadowBlur,
              ),
            ],
          ),
        ),

        // --- Outline ---
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = outlineWidth
              ..color = outlineColor,
          ),
        ),

        // --- Fill Text ---
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: fillColor,
          ),
        ),
      ],
    );
  }
}
