import 'package:dartz/dartz.dart';

import '../../core/value_object.dart';
import 'url_failure.dart';

class Url extends ValueObject<UrlFailure, String> {
  factory Url(String input) {
    return Url._(_validate(input));
  }
  const Url._(this.value);
  final Either<UrlFailure, String> value;
  static Either<UrlFailure, String> _validate(String input) {
    const urlRegex =
        r'^(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})$';
    if (input.isEmpty) return left(UrlFailure.empty(input));
    if (!RegExp(urlRegex).hasMatch(input))
      return left(UrlFailure.invalid(input));
    return right(input);
  }
}
