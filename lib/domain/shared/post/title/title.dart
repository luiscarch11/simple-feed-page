import 'package:dartz/dartz.dart';

import '../../core/value_object.dart';
import 'title_failure.dart';

class Title extends ValueObject<TitleFailure, String> {
  factory Title(String input) {
    return Title._(_validate(input));
  }
  const Title._(this.value);
  final Either<TitleFailure, String> value;
  static Either<TitleFailure, String> _validate(String input) {
    if (input.isEmpty) return left(TitleFailure.empty());
    if (input.length < minCharacters) return left(TitleFailure.tooShort(input));
    if (input.length > maxCharacters) return left(TitleFailure.tooLong(input));
    return right(input);
  }

  static int get minCharacters => 3;
  static int get maxCharacters => 70;
}
