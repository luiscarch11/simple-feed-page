import 'package:flutter/material.dart';

import 'colors.dart';

class RoundedButtonWidget extends StatelessWidget {
  const RoundedButtonWidget({
    Key? key,
    this.onTap,
    this.fractionalWidth = 1,
    this.height,
    this.borderColor,
    this.backgroundColor,
    this.text = '',
    this.textColor,
    this.boldText = false,
  })  : assert(fractionalWidth <= 1),
        super(key: key);
  final void Function()? onTap;
  final double fractionalWidth;
  final double? height;
  final Color? borderColor;
  final Color? backgroundColor;
  final String text;
  final Color? textColor;
  final bool boldText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: FractionallySizedBox(
        widthFactor: fractionalWidth,
        child: Container(
          height: height ?? 45,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? FeedColors.blue),
            color: backgroundColor ?? FeedColors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.button!.copyWith(
                    color: textColor ?? FeedColors.light,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
