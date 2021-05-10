import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../shared/colors.dart';
import '../shared/text_field_widget.dart';
import 'calendar_widget.dart';

class DateSelectorTextFieldWidget extends StatelessWidget {
  const DateSelectorTextFieldWidget({
    Key? key,
    required this.value,
    this.isHidden = false,
    required this.onChanged,
    required this.closeFunction,
    this.counter,
    this.headerText = '',
    this.validator,
    this.showError = false,
    this.closeOnChanged = true,
  }) : super(key: key);
  final DateTime? value;
  final bool isHidden;
  final bool showError;
  final VoidCallback closeFunction;

  final String headerText;
  final ValueChanged<DateTime> onChanged;

  final bool closeOnChanged;

  final String? Function(String?)? validator;
  final Widget? counter;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            closeFunction();
          },
          child: TextFieldWidget(
            showError: showError,
            onTap: closeFunction,
            validator: validator,
            headerText: headerText,
            isDisabled: true,
            counter: counter,
            suffixIcon: Icon(
              Icons.calendar_today_outlined,
              color: FeedColors.blue,
            ),
            controller: TextEditingController(
              text:
                  value == null ? '' : DateFormat('yyyy-MM-dd').format(value!),
            ),
          ),
        ),
        CalendarWidget(
          initialDate: value ?? DateTime.now(),
          onChanged: (date) {
            onChanged(date);
            if (closeOnChanged) closeFunction();
          },
          isHidden: isHidden,
        )
      ],
    );
  }
}
