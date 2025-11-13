import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recharge_max/core/ui/assets.dart';
import 'package:recharge_max/core/ui/colors.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.alwaysShowButton = false, this.onBackPressed});
  final bool alwaysShowButton;
  final Function()? onBackPressed;

  @override
  Widget build(BuildContext context) {
    if (Navigator.of(context).canPop() || alwaysShowButton) {
      return GestureDetector(
        onTap: () {
          if(onBackPressed!=null) {
            onBackPressed!();
          }else{
            Navigator.of(context).pop();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SvgPicture.asset(
            Assets.arrowLeft,
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
