import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.error,
            color: FeedColors.error,
          ),
          Text(
            message,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: FeedColors.light,
                ),
          ),
          Container(),
        ],
      ),
    ),
  );
}

showSuccess(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.check,
            color: FeedColors.success,
          ),
          Text(
            message,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: FeedColors.light,
                ),
          ),
        ],
      ),
    ),
  );
}
