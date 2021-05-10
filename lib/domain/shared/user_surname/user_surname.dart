import 'package:dartz/dartz.dart';

import '../core/value_object.dart';
import 'user_surname_failure.dart';

class UserSurname extends ValueObject<UserSurnameFailure, String> {
  UserSurname._(this.value);

  factory UserSurname(String input) {
    return UserSurname._(
      _validate(input.trim()),
    );
  }
  final Either<UserSurnameFailure, String> value;

  static Either<UserSurnameFailure, String> _validate(String input) {
    const regex = r'^[ña-zÑA-ZÀ-ÿ]{2,}$';

    if (input.isEmpty) {
      return left(UserSurnameFailure.empty());
    }

    if (input.length < minCharacters) {
      return left(UserSurnameFailure.tooShort(input));
    }
    if (input.length > maxCharacters) {
      return left(UserSurnameFailure.tooLong(input));
    }
    if (!RegExp(regex).hasMatch(input)) {
      return left(UserSurnameFailure.invalid(input));
    }

    return right(input);
  }

  static int get maxCharacters => 40;
  static int get minCharacters => 2;
}
