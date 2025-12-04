import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recharge_max/core/ui/assets.dart';
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
      {'name': 'MTN', 'icon': Assets.mtn},
      {'name': 'Airtel', 'icon': Assets.airtel},
      {'name': 'Glo', 'icon': Assets.glo},
      {'name': '9mobile', 'icon': Assets.nineMobile},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 12.w,
        children: providers.map((provider) {
          final isSelected = selectedProvider == provider['name'];
          return GestureDetector(
            onTap: () => onProviderSelected(provider['name']!),
            child: Container(
              // width: (MediaQuery.of(context).size.width - 48.w) / 4,
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.colorPrimary.withOpacity(0.1) : Colors.white,
                border: Border.all(
                  color: isSelected ? AppColors.colorPrimary : Colors.transparent,
                  width: isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    provider['icon']!,
                    width: 65.w,
                    height: 65.w,
                  ),
                  // SizedBox(height: 8.h),
                  // Text(
                  //   provider['name']!,
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     color: isSelected ? AppColors.colorPrimary : AppColors.colorBlack,
                  //     fontSize: 12.sp,
                  //     fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
