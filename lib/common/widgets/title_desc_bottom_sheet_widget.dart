import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recharge_max/common/widgets/widgets.dart';
import 'package:recharge_max/core/ui/colors.dart';

class TitleDescBottomSheetWidget extends StatefulWidget {
  const TitleDescBottomSheetWidget({super.key, required this.title, required this.desc});
  final String title, desc;

  @override
  State<TitleDescBottomSheetWidget> createState() => _TitleDescBottomSheetWidgetState();
}

class _TitleDescBottomSheetWidgetState extends State<TitleDescBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Keeps the bottom sheet height dynamic
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          // Title text
           Text(
            widget.title ,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: AppColors.black100
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Subtext
           Text(
            widget.desc,
             textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.grey50,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 24),

          // Okay button
          AppButton.fill(
            context: context,
            size: Size(size.width, 48),
            text: 'Okay',
            onPressed: () async {
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}
