import 'package:flutter/material.dart';

import 'colors.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    this.prefix,
    this.showError = false,
    this.initialValue,
    this.onChanged,
    this.onTap,
    this.isDisabled = false,
    this.controller,
    this.validator,
    this.maxLines = 1,
    this.expands = false,
    this.isNumeric = false,
    this.helperText = '',
    this.headerText = '',
    this.hintText = '',
    this.isPassword = false,
    this.counter,
    this.suffixIcon,
  }) : super(key: key);
  final bool showError;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool isDisabled;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int maxLines;
  final bool expands;
  final bool isNumeric;
  final String helperText;
  final String headerText;
  final String hintText;
  final bool isPassword;
  final Widget? counter;
  final Widget? suffixIcon;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          initialValue: initialValue,
          keyboardType: isNumeric ? TextInputType.number : null,
          onChanged: onChanged,
          autovalidateMode:
              showError ? AutovalidateMode.always : AutovalidateMode.disabled,
          onTap: onTap,
          readOnly: isDisabled,
          controller: controller,
          validator: validator,
          maxLines: maxLines,
          expands: expands,
          decoration: InputDecoration(
            suffixIconConstraints: BoxConstraints(maxWidth: 30),
            suffixIcon: Container(
              margin: EdgeInsets.only(right: 10),
              child: suffixIcon ?? Container(),
            ),
            errorMaxLines: 2,
            fillColor: FeedColors.light,
            filled: true,
            helperText: helperText,
            hintText: hintText,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                width: 1.5,
                color: FeedColors.grey,
              ),
            ),
            counter: counter,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: FeedColors.blue,
              ),
            ),
            contentPadding: EdgeInsets.only(
              left: 15,
              top: 10,
              bottom: 10,
            ),
          ),
          cursorColor: FeedColors.blue,
          obscureText: isPassword,
        ),
      ],
    );
  }
}
