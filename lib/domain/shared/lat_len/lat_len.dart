import 'package:dartz/dartz.dart';

import '../core/value_object.dart';
import 'lat_len_failure.dart';

class LatLen extends ValueObject<LatLenFailure, double> {
  const LatLen._(this.value);
  factory LatLen(String input) {
    return LatLen._(_validate(input));
  }
  final Either<LatLenFailure, double> value;
  static Either<LatLenFailure, double> _validate(String input) {
    final transformedInput = double.tryParse(input);
    if (transformedInput == null) return left(LatLenFailure.invalid(input));

    return right(transformedInput);
  }
}
