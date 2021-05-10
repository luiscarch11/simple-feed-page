import 'package:dartz/dartz.dart';

import '../core/value_object.dart';
import 'user_name_failure.dart';

class UserName extends ValueObject<UserNameFailure, String> {
  const UserName._(this.value);
  factory UserName(String input) {
    return UserName._(
      _validate(input.trim()),
    );
  }
  final Either<UserNameFailure, String> value;

  static Either<UserNameFailure, String> _validate(String input) {
    const userFullNameRegex = r'^[ña-zÑA-ZÀ-ÿ]{4,}(?: [ña-zÑA-ZÀ-ÿ]+){0,2}$';
    if (input.length > maxCharacters)
      return left(UserNameFailure.tooLong(input));
    if (input.length < minCharacters)
      return left(UserNameFailure.tooShort(input));
    if (input.isEmpty) return left(UserNameFailure.empty());
    if (RegExp(userFullNameRegex).hasMatch(input)) {
      return right(input);
    }
    return left(
      UserNameFailure.invalid(input),
    );
  }

  static int get maxCharacters => 30;
  static int get minCharacters => 4;
}
