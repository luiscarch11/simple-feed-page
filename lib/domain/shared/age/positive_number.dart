import 'package:dartz/dartz.dart';

import '../core/value_object.dart';
import 'positive_number_failure.dart';

class PositiveNumber extends ValueObject<PositiveNumberFailure, int> {
  factory PositiveNumber(String input) {
    return PositiveNumber._(_validate(input));
  }
  const PositiveNumber._(this.value);
  final Either<PositiveNumberFailure, int> value;
  static Either<PositiveNumberFailure, int> _validate(String input) {
    final transformedInput = int.tryParse(input);
    if (transformedInput == null)
      return left(PositiveNumberFailure.invalid(input));
    if (transformedInput < minimum)
      return left(PositiveNumberFailure.tooSmall(transformedInput));
    return right(transformedInput);
  }

  static int get minimum => 1;
}
