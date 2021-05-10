import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'unexpected_value_error.dart';
import 'value_failure.dart';

@immutable
abstract class ValueObject<L extends ValueFailure, R> {
  const ValueObject();
  Either<L, R> get value;
  R getOrCrash() => value.fold(
        (l) => throw UnexpectedValueError<L>(l),
        (r) => r,
      );

  bool get isValid => value.isRight();
  bool get isInvalid => value.isLeft();
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ValueObject<L, R> && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}
