import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_max/core/ui/app_theme.dart';
import 'package:recharge_max/core/ui/colors.dart';

class RecentWinnersSection extends StatelessWidget {
  const RecentWinnersSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.colorWhite
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Winners',
            style: TextStyle(
              color: AppColors.colorBlack,
              fontSize: 18.sp,
              fontFamily: AppTheme.roboto,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height:20.h),
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
      ),
    );
  }

  List<Widget> _buildWinnersList() {
    final winners = [
      {'phone': '080****1234', 'prize': '₦50000'},
      {'phone': '080****1234', 'prize': '₦50000'},
      {'phone': '080****1234', 'prize': '₦50000'},
    ];

    return winners.map((winner) {
      return Column(
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.orange600.withOpacity(.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.account_circle_outlined,
                  color: AppColors.orange800,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      winner['phone']!,
                      style: TextStyle(
                        color: AppColors.colorBlack,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // SizedBox(height: 2.h),
                    Text(
                      'Daily Draw Winner',
                      style: TextStyle(
                        color: AppColors.grey350,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                decoration: BoxDecoration(
                  color: AppColors.orange600.withOpacity(.1),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Text(
                  winner['prize']!,
                  style: TextStyle(
                    color: AppColors.orange800,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Divider(
              color: AppColors.grey350.withOpacity(.8),
              thickness: .5,
            ),
          )
        ],
      );
    }).toList();
  }
}
