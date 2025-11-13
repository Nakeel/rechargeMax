import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recharge_max/core/ui/colors.dart';

class InfoCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final Widget? titleDescWiget;

  const InfoCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      this.titleDescWiget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color:
                  AppColors.colorTextFieldBorder.withAlpha((.1 * 255).round()),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              icon,
              width: 15,
              height: 15,
              fit: BoxFit.contain,
              colorFilter: const ColorFilter.mode(
                AppColors.black100,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.black100)),
                const SizedBox(height: 4),
                if (titleDescWiget != null)
                  titleDescWiget ?? const SizedBox.shrink(),
                Text(subtitle,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.grey50)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
