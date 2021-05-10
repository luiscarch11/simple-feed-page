import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

import '../core/value_object.dart';
import 'unique_id_failure.dart';

class UniqueId extends ValueObject<UniqueIdFailure, String> {
  factory UniqueId() => UniqueId._(right(Uuid().v1()));

  UniqueId._(this.value);
  factory UniqueId.fromString(String id) {
    return UniqueId._(_validate(id));
  }
  final Either<UniqueIdFailure, String> value;

  static Either<UniqueIdFailure, String> _validate(String id) {
    if (id.isEmpty) {
      return left(UniqueIdFailure.empty());
    }

    return right(id);
  }
}
