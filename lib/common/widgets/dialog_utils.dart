
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recharge_max/core/ui/app_theme.dart';
import 'package:recharge_max/core/ui/assets.dart';
import 'package:recharge_max/core/ui/colors.dart';

import 'app_button.dart';
import 'app_text.dart';

class DialogUtils {
  static Future<void> showCustomStatusDialog({
    required BuildContext context,
    required String title,
    required String description,
    required String mainButtonTitle,
    required Function() mainButtonAction,
    String? iconAssest,
    bool showCancelButton = false,
    bool isSuccess = true,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing by tapping outside
      builder: (BuildContext contxt) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Rounded corners
          ),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 15, vertical: 30), // Spacing
          content: Column(
            mainAxisSize: MainAxisSize.min, // Wrap content
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon or image
              Center(
                child: Image.asset( iconAssest ??
                    (isSuccess
                        ? Assets.success
                        : Assets.failure),
                  height: 115,
                  width: 115,
                ),
              ),
              const SizedBox(height: 16),
              // Title
              Center(
                child: TextView(
                  text: title,
                  fontFamily: AppTheme.opensans,
                  color: AppColors.colorOffBlack,
                  textAlign: TextAlign.center,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              // Description
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextView(
                    text: description,
                    fontSize: 14,
                    textAlign: TextAlign.center,
                    color: AppColors.unselectedColorBlack,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Main Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AppButton.fill(
                  context: context,
                  text: mainButtonTitle,
                  disabled: false,
                  loading: false,
                  onPressed: () {
                    // mainButtonAction();
                    // Navigator.of(contxt.pop(); // Close dialog after action
                    contxt.pop();
                    // Future.delayed(const Duration(milliseconds: 400), () {
                    mainButtonAction(); // Pop the calling screen
                    // });
                  },
                ),
              ),
              if (showCancelButton) ...[
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () {
                      contxt.pop();
                    },
                    child:  TextView(
                      text: "Cancel",
                      fontSize: 14,
                      textAlign: TextAlign.center,
                      color: AppColors.colorPrimary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }


}
