import 'package:dartz/dartz.dart';

import '../core/value_object.dart';
import 'email_failure.dart';

class EmailAddress extends ValueObject<EmailFailure, String> {
  factory EmailAddress(String input) {
    return EmailAddress._(
      _validate(input.trim()),
    );
  }

  EmailAddress._(this.value);
  final Either<EmailFailure, String> value;

  static Either<EmailFailure, String> _validate(String input) {
    const emailRegex = r'^[a-zA-Z0-9.a-zA-Z0-9._\-]+@[a-zA-Z0-9]+\.[a-zA-Z]+';

    if (input.isEmpty) {
      return left(EmailFailure.empty());
    }

    if (!RegExp(emailRegex).hasMatch(input)) {
      return left(EmailFailure.invalid(input));
    }

    return right(input);
  }
}
