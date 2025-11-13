import 'package:flutter/material.dart';

class OutlinedText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fillColor;
  final Color outlineColor;
  final double strokeWidth;
  final TextAlign textAlign;

  const OutlinedText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.fillColor = Colors.white,
    this.outlineColor = Colors.black,
    this.strokeWidth = 2,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Outline
        Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = outlineColor,
          ),
        ),
        // Fill
        Text(
          text,
          textAlign: textAlign,
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
