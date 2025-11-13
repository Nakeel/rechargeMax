// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:recharge_max/core/ui/assets.dart';
import 'package:recharge_max/core/ui/colors.dart';

class GreyTextDivider extends StatelessWidget {
  const GreyTextDivider({
    super.key,
    this.fontWeight,
    required this.text,
    this.fontSize,
    this.showInfoIcon = true,
    this.height,
  });

  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? height;
  final bool showInfoIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: const Color(0xffFAFAFA),
      child: Row(
        children: [
          if (showInfoIcon) ...[
            Row(
              children: [
                SvgPicture.asset(Assets.greyInfoOutlined),
                SizedBox(width: 8.w),
              ],
            ),
          ],
          Text(
            text,
            style: TextStyle(
              fontWeight: fontWeight ?? FontWeight.w400,
              fontSize: fontSize ?? 13,
              color: AppColors.grey300,
            ),
          ),
        ],
      ),
    );
  }
}
