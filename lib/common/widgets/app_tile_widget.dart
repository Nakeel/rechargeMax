import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AppSimpleTile extends StatelessWidget {
  const AppSimpleTile({
    super.key,
    required this.locationTitle,
    required this.zone,
    this.leading,
    this.onTap,
  });

  final String locationTitle;
  final String zone;
  final Widget? leading;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE4E6E8), width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                leading!,
                SizedBox(
                  width: 10.sp,
                ),
                Text(
                  locationTitle,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 12.sp,
              color: const Color(0XFF242628),
            ),
          ],
        ),
      ),
    );
  }
}