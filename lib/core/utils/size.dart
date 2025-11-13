import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class S {
  static SizedBox h(double height) {
    return SizedBox(height: height.h);
  }

  static bool isMobile(BuildContext context) {
    // The equivalent of the "smallestWidth" qualifier on Android.
    var smallestDimension = MediaQuery.of(context).size.shortestSide;

// Determine if we should use mobile layout or not. The
// number 600 here is a common breakpoint for a typical
// 7-inch tablet.
    return smallestDimension < 600;
  }

  static SizedBox rbh(BuildContext context, double percent) {
    return SizedBox(height: rH(context, percent).h);
  }

  static SizedBox rbw(BuildContext context, double percent) {
    return SizedBox(width: rW(context, percent).w);
  }

  static double rH(BuildContext context, double h) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (isPortrait) {
      return (MediaQuery.of(context).size.height * h).h;
    } else {
      return (MediaQuery.of(context).size.width * h).h;
    }
  }

  static double rW(BuildContext context, double w) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (isPortrait) {
      return (MediaQuery.of(context).size.width * w).w;
    } else {
      return (MediaQuery.of(context).size.height * w).w;
    }
  }

  static SizedBox w(double width, [BuildContext? context]) {
    return SizedBox(width: width.w);
  }

  static double _screenWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  static availableScreenWidth(context) {
    return _screenWidth(context) - ((S.appHorizontalPadding).r * 2);
  }

  static double appHorizontalPadding = 24.0;
}
