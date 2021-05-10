import 'package:dartz/dartz.dart';

import '../../core/value_object.dart';
import 'interest_name_failure.dart';

class InterestName extends ValueObject<InterestNameFailure, String> {
  const InterestName._(this.value);
  factory InterestName(String input) {
    return InterestName._(
      _validate(input.trim()),
    );
  }
  final Either<InterestNameFailure, String> value;

  static Either<InterestNameFailure, String> _validate(String input) {
    const userFullNameRegex = r'^[ña-zÑA-ZÀ-ÿ]+ [ña-zÑA-ZÀ-ÿ]+$';
    if (input.isEmpty) return left(InterestNameFailure.empty());
    if (input.length > maxCharacters)
      return left(InterestNameFailure.tooLong(input));

    if (RegExp(userFullNameRegex).hasMatch(input)) {
      return right(input);
    }
    return left(
      InterestNameFailure.invalid(input),
    );
  }

  static int get maxCharacters => 30;
  static int get minCharacters => 4;
}
