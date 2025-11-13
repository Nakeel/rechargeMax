import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recharge_max/common/widgets/app_text.dart';
import 'package:recharge_max/core/ui/colors.dart';

import 'image_shimmer_widget_loader.dart';


class CatNavItemWidget extends StatelessWidget {
  const CatNavItemWidget({
    super.key, required this.title, required this.assetPath, this.onItemClicked,
  });
  final String title, assetPath;
  final Function()? onItemClicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: InkWell(
        onTap: onItemClicked,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                    color: AppColors.itemGrey,
                    shape: BoxShape.circle
                ),
                height: 80,
                width: 80,
                child: Center(
                  child: ImageWidgetWithShimmerLoader(
                    image: assetPath,
                    shape: 'circle',
                    height: 80,
                    width: 80,
                  )
                )
            ),
            SizedBox(height: 8,),
            TextView(text: title,
              fontSize: 12,
              fontWeight: FontWeight.w400,)
          ],
        ),
      ),
    );
  }
}