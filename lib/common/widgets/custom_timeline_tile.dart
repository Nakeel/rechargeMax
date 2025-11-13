import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:recharge_max/core/ui/colors.dart';

class CustomTimeLineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final String title;
  final String? date;
  final IconData? icon;

  const CustomTimeLineTile({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    required this.title,
    this.date,
    this.icon
  });

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(
        thickness: 2,
        color: isPast ? AppColors.colorPrimary : AppColors.itemGrey,
      ),
      indicatorStyle: IndicatorStyle(
        width: 25,
        color: isPast ? AppColors.colorPrimary : AppColors.itemGrey,
        iconStyle: IconStyle(
          iconData:icon?? Icons.check_circle_sharp,
          color: isPast ? Colors.white : AppColors.descTextGrey,
        ),
      ),
      endChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (date != null) ...[
              const SizedBox(height: 4),
              Text(
                date ?? '',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.grey300,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}