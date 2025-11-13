import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recharge_max/core/ui/assets.dart';
import 'package:recharge_max/core/ui/colors.dart';

import 'app_input.dart';

class AppTimePicker extends StatefulWidget {
  const AppTimePicker({
    super.key,
    required this.controller,
    required this.label,
  });

  final String label;
  final TextEditingController controller;

  @override
  State<AppTimePicker> createState() => _AppTimePickerState();
}

class _AppTimePickerState extends State<AppTimePicker> {
  Future<TimeOfDay?> _selectTime(
      BuildContext context, TimeOfDay? selectedTime) async {
    return await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
  }

  Future<TimeOfDay?> _selectCupertinoTime(
      BuildContext context, DateTime? selectedDate) async {
    TimeOfDay? timePicked;

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: AppColors.colorWhite,
          height: 400.h,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: selectedDate ?? DateTime.now(),
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                timePicked = TimeOfDay.fromDateTime(newDateTime);
              });
            },
          ),
        );
      },
    );

    return timePicked;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: widget.controller,
      label: widget.label,
      hint: widget.controller.text.isEmpty ? 'HH:MM' : widget.controller.text,
      readOnly: true,
      onTap: () async {
        TimeOfDay? departureTime;

        if (Theme.of(context).platform == TargetPlatform.iOS) {
          departureTime = await _selectCupertinoTime(
            context,
            null,
          );
        } else {
          departureTime = await _selectTime(
            context,
            widget.controller.text.isEmpty
                ? null
                : TimeOfDay(
                    hour: DateTime.parse(
                      widget.controller.text.isEmpty
                          ? '00:00'
                          : widget.controller.text,
                    ).hour,
                    minute: DateTime.parse(
                      widget.controller.text.isEmpty
                          ? '00:00'
                          : widget.controller.text,
                    ).minute,
                  ),
          );
        }

        if (mounted) {
          widget.controller.text =
              departureTime == null ? '' : departureTime.format(context);
        }
      },
      suffixIcon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            Assets.clock,
            colorFilter: ColorFilter.mode(
              Theme.of(context).primaryColor,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}
