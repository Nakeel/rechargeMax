import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_max/core/ui/colors.dart';

class RecentWinnersSection extends StatelessWidget {
  const RecentWinnersSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Winners',
          style: TextStyle(
            color: AppColors.colorBlack,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        ..._buildWinnersList(),
        SizedBox(height: 16.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightGrey,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h),
            ),
            child: Text(
              'View More',
              style: TextStyle(
                color: AppColors.descTextGrey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildWinnersList() {
    final winners = [
      {'phone': '080****1234', 'prize': '₦50000'},
      {'phone': '080****1234', 'prize': '₦50000'},
      {'phone': '080****1234', 'prize': '₦50000'},
    ];

    return winners.map((winner) {
      return Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFFFFC947),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.emoji_events,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    winner['phone']!,
                    style: TextStyle(
                      color: AppColors.colorBlack,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Daily Draw Winner',
                    style: TextStyle(
                      color: AppColors.descTextGrey,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              winner['prize']!,
              style: TextStyle(
                color: const Color(0xFFFFC947),
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
