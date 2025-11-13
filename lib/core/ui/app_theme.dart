import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static String geist = 'Geist';
  static String roboto = 'Roboto';

  static ThemeData theme(BuildContext context) => ThemeData(
        useMaterial3: true,
        dialogTheme: const DialogTheme(
          backgroundColor: AppColors.colorWhite,
          surfaceTintColor: AppColors.colorWhite,
        ),
        dialogBackgroundColor: AppColors.colorWhite,
        splashColor: AppColors.primarySwatch[50],
        disabledColor: AppColors.neutralSwatch[100],
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)))),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.colorWhite,
          foregroundColor: AppColors.colorWhite,
          surfaceTintColor: AppColors.colorWhite,
          titleTextStyle: TextStyle(
            color: AppColors.colorBlack,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: AppTheme.geist,
          ),
          iconTheme: const IconThemeData(
            color: AppColors.colorBlack,
          ),
          elevation: 0,
        ),
        fontFamily: AppTheme.geist,
        dividerTheme: DividerThemeData(
            color: AppColors.neutralSwatch[100], thickness: 1, space: 0),
        scaffoldBackgroundColor: AppColors.colorWhite,
        bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: AppColors.colorWhite,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        primaryColor: AppColors.primarySwatch[500],
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: AppColors.primarySwatch,
          errorColor: AppColors.errorColor,
        ),
      );
}
