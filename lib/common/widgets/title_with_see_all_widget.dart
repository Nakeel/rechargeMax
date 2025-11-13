import 'package:flutter/material.dart';
import 'package:recharge_max/common/widgets/app_text.dart';
import 'package:recharge_max/core/ui/colors.dart';


class TitleWithSeeAllWidget extends StatelessWidget {
  const TitleWithSeeAllWidget({
    super.key, required this.title, this.onSeeAllClicked,
  });
  final String title;
  final Function()? onSeeAllClicked;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextView(text: title,
          fontWeight: FontWeight.w700,
          fontSize: 18,

        ),
        InkWell(
          onTap: onSeeAllClicked,
          borderRadius: BorderRadius.circular(50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextView(text: 'See all',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.grey300,
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grey400
                ),
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: Icon(Icons.arrow_forward_ios, size: 8,
                  color: AppColors.colorBlack,),
              )
            ],
          ),
        )
      ],
    );
  }
}