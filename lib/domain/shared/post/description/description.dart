import 'package:dartz/dartz.dart';

import '../../core/value_object.dart';
import 'description_failure.dart';

class Description extends ValueObject<DescriptionFailure, String> {
  factory Description(String input) {
    return Description._(_validate(input));
  }
  const Description._(this.value);
  
  final Either<DescriptionFailure, String> value;
  static Either<DescriptionFailure, String> _validate(String input) {
    if (input.isEmpty) return left(DescriptionFailure.empty());
    if (input.length < minCharacters)
      return left(DescriptionFailure.tooShort(input));
    if (input.length > maxCharacters)
      return left(DescriptionFailure.tooLong(input));
    return right(input);
  }

  static int get minCharacters => 20;
  static int get maxCharacters => 1100;
}
