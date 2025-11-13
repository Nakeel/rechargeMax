import 'package:flutter/material.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:shimmer/shimmer.dart';

class Loaders {
  static Widget circularProgress = const Center(
    child: CircularProgressIndicator(
      strokeWidth: 2,
    ),
  );
  static Widget circularLoader = const CircularProgressIndicator.adaptive(
    strokeWidth: 2.0,
    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
  );

  static Widget appLoader = Row(
    children: [
      SizedBox(
        height: 20,
        width: 20,
        child: Loaders.circularLoader,
      ),
      const SizedBox(width: 10,),
      const Text(
        'Verifying...',
        style: TextStyle(
          fontSize: 16,
          color: AppColors.colorBlack,
        ),
      ),
    ],
  );

  static Widget shimmerLoader = Shimmer(
    gradient: LinearGradient(colors: [Colors.grey.shade300, Colors.white]),
    child: Container(
      color: Colors.grey.shade300,
    ),
  );

  static Widget finiteCircularProgressIndecator(double value) {
    return CircularProgressIndicator(
      value: value,
      strokeWidth: 2.0,
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
      backgroundColor: AppColors.colorBlack.withOpacity(0.2),
      color: AppColors.colorBlack.withOpacity(0.5),
    );
  }
}
