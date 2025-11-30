import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recharge_max/core/ui/colors.dart';

class NetworkProviderSelector extends StatelessWidget {
  final String? selectedProvider;
  final Function(String) onProviderSelected;

  const NetworkProviderSelector({
    Key? key,
    required this.selectedProvider,
    required this.onProviderSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providers = [
      {'name': 'MTN', 'icon': 'assets/svg/mtn.svg'},
      {'name': 'Airtel', 'icon': 'assets/svg/airtel.svg'},
      {'name': 'Glo', 'icon': 'assets/svg/glo.svg'},
      {'name': '9mobile', 'icon': 'assets/svg/9mobile.svg'},
    ];

    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: providers.map((provider) {
        final isSelected = selectedProvider == provider['name'];
        return GestureDetector(
          onTap: () => onProviderSelected(provider['name']!),
          child: Container(
            width: (MediaQuery.of(context).size.width - 48.w) / 4,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.colorPrimary.withOpacity(0.1) : Colors.white,
              border: Border.all(
                color: isSelected ? AppColors.colorPrimary : AppColors.naturalGrey,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  provider['icon']!,
                  width: 40.w,
                  height: 40.w,
                ),
                SizedBox(height: 8.h),
                Text(
                  provider['name']!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? AppColors.colorPrimary : AppColors.colorBlack,
                    fontSize: 12.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
