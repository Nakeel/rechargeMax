import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recharge_max/core/ui/assets.dart';
import 'package:recharge_max/core/ui/colors.dart';

enum SnackbarType { success, error, warning, info }

enum SnackbarPosition { top, center, bottom }

class CustomSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
    SnackbarPosition position = SnackbarPosition.top,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    Color bgColor;
    Widget icon;
    Color borderColor;

    switch (type) {
      case SnackbarType.success:
        bgColor = Colors.green.shade100;
        borderColor = Colors.green;
        icon = Icon(Icons.check_circle, color: borderColor);
        break;
      case SnackbarType.error:
        bgColor = AppColors.colorRedLight;
        borderColor = AppColors.colorRed;
        icon = SvgPicture.asset(Assets.redXCircle);
        break;
      case SnackbarType.warning:
        bgColor = Colors.orange.shade100;
        borderColor = Colors.orange;
        icon = Icon(Icons.warning, color: borderColor);
        break;
      default:
        bgColor = Colors.blue.shade100;
        borderColor = Colors.blue;
        icon = Icon(Icons.info, color: borderColor);
    }

    final opacityNotifier = ValueNotifier<double>(0.0);

    overlayEntry = OverlayEntry(
      builder: (context) {
        Alignment alignment;
        EdgeInsets padding;

        switch (position) {
          case SnackbarPosition.top:
            alignment = Alignment.topCenter;
            padding = EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              left: 40,
              right: 40,
            );
            break;
          case SnackbarPosition.center:
            alignment = Alignment.center;
            padding = const EdgeInsets.symmetric(horizontal: 40);
            break;
          case SnackbarPosition.bottom:
            alignment = Alignment.bottomCenter;
            padding = EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 100,
              left: 40,
              right: 40,
            );
            break;
        }

        return Align(
          alignment: alignment,
          child: Padding(
            padding: padding,
            child: Material(
              color: Colors.transparent,
              child: ValueListenableBuilder<double>(
                valueListenable: opacityNotifier,
                builder: (context, opacity, child) {
                  return AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(milliseconds: 300),
                    child: child,
                  );
                },
                child: IntrinsicWidth(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(80),
                      border: Border.all(color: borderColor),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        icon,
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            message,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(overlayEntry);

    // Fade in
    Future.delayed(const Duration(milliseconds: 50), () {
      opacityNotifier.value = 1.0;
    });

    // Fade out
    Future.delayed(duration, () {
      opacityNotifier.value = 0.0;
      Future.delayed(const Duration(milliseconds: 300), () {
        overlayEntry.remove();
      });
    });
  }
}
