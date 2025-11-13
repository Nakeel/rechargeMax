import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final Color activeColor;
  final Color inactiveColor;

  const PageIndicator({
    Key? key,
    required this.itemCount,
    required this.currentIndex,
    this.activeColor = Colors.white,
    this.inactiveColor = Colors.white30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(itemCount, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 20,
          height: 6,
          decoration: BoxDecoration(
            color: currentIndex == index ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}
