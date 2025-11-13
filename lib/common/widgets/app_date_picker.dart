import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:recharge_max/core/ui/assets.dart';
import 'package:recharge_max/core/ui/colors.dart';

import 'app_input.dart';

class AppDatePicker extends StatefulWidget {
  const AppDatePicker({
    super.key,
    required this.controller,
    required this.label,
    this.initialDate,
    this.lastDate,
    this.onChnage,
  });

  final String label;
  final TextEditingController controller;
  final DateTime? initialDate;
  final DateTime? lastDate;
  final Function? onChnage;

  @override
  State<AppDatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<AppDatePicker> {
  Future<DateTime?> _selectCupertinoDate(
      BuildContext context, DateTime? selectedDate) async {
    DateTime? newDate;

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: AppColors.colorWhite,
          height: 400.h,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: selectedDate ?? widget.lastDate ?? DateTime.now(),
            minimumDate: widget.initialDate,
            maximumDate: widget.lastDate,
            onDateTimeChanged: (DateTime date) {
              setState(() {
                newDate = date;
              });
              widget.onChnage?.call(newDate);
            },
          ),
        );
      },
    );

    return newDate;
  }

  Future<DateTime?> _selectDate(
      BuildContext context, DateTime? selectedDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? widget.lastDate ?? DateTime.now(),
      firstDate: widget.initialDate ?? DateTime(2000),
      lastDate: widget.lastDate ?? DateTime(2101),
    );

    return pickedDate;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: widget.controller,
      label: widget.label,
      hint: widget.controller.text.isEmpty
          ? 'DD-MM-YYYY'
          : widget.controller.text,
      readOnly: true,
      onTap: () async {
        DateTime? arrivalDate;

        if (Theme.of(context).platform == TargetPlatform.iOS) {
          arrivalDate = await _selectCupertinoDate(
            context,
            widget.controller.text.isEmpty
                ? null
                : DateFormat('dd-MM-yyyy').parse(widget.controller.text),
          );
        } else {
          arrivalDate = await _selectDate(
              context,
              widget.controller.text.isEmpty
                  ? null
                  : DateFormat('dd-MM-yyyy').parse(widget.controller.text));
        }
        widget.controller.text = arrivalDate == null
            ? ''
            : DateFormat('dd-MM-yyyy').format(arrivalDate);
      },
      suffixIcon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            Assets.calendar,
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
