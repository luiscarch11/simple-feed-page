import 'package:flutter/material.dart' hide DayPicker;

import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({
    Key? key,
    required this.initialDate,
    required this.onChanged,
    this.isHidden = false,
  }) : super(key: key);
  final DateTime initialDate;
  final bool isHidden;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isHidden
          ? Container()
          : SfDateRangePicker(
              view: DateRangePickerView.month,
              onSelectionChanged: (dateRangePickerSelectionChangedArgs) =>
                  onChanged(
                      dateRangePickerSelectionChangedArgs.value as DateTime),
            ),
    );
  }
}
