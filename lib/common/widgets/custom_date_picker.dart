import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:recharge_max/core/ui/colors.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime? initialDate, firstDate, lastDate;
  final void Function(List<DateTime?>)? onValueChanged;

  const CustomDatePicker({
    super.key,
    required this.initialDate,
    this.onValueChanged, this.firstDate, this.lastDate,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return CalendarDatePicker2(
      config: CalendarDatePicker2Config(
        calendarType: CalendarDatePicker2Type.single,
        selectedDayHighlightColor: AppColors.colorPrimary,
        firstDate: widget.firstDate,
        lastDate:widget.lastDate,
        selectedDayTextStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
      value: widget.initialDate != null ? [widget.initialDate] : [],
      onValueChanged: widget.onValueChanged,
    );
  }
}
