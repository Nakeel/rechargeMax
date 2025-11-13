import 'package:flutter/material.dart';
import 'package:recharge_max/core/ui/colors.dart';


class TitleDescWidget extends StatelessWidget {
  const TitleDescWidget({
    super.key, required this.title, required this.desc, this.titleStyle, this.descStyle,
    this.isLoading = false
  });
  final String title, desc;
  final TextStyle? titleStyle, descStyle;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title,
            style: titleStyle ?? TextStyle(fontWeight: FontWeight.w400, fontSize: 12,
                color: AppColors.grey50)),
        isLoading ?
            SizedBox(
              height: 10,
                width: 10,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorPrimary),
                )):
        Text(desc,
            style: descStyle ??  TextStyle(fontWeight: FontWeight.w500, fontSize: 12,
                color: AppColors.black100)),
      ],
    );
  }
}