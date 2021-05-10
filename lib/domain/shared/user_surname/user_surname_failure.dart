import '../core/value_failure.dart';

abstract class UserSurnameFailure extends ValueFailure {
  const UserSurnameFailure();
  factory UserSurnameFailure.empty() = UserSurnameFailureEmpty;
  factory UserSurnameFailure.invalid(String value) = UserSurnameFailureInvalid;
  factory UserSurnameFailure.tooLong(String value) = UserSurnameFailureTooLong;
  factory UserSurnameFailure.tooShort(String value) =
      UserSurnameFailureTooShort;

  void when({
    required void Function(UserSurnameFailureEmpty) empty,
    required void Function(UserSurnameFailureInvalid) invalid,
    required void Function(UserSurnameFailureTooLong) tooLong,
    required void Function(UserSurnameFailureTooShort) tooShort,
  }) {
    if (this is UserSurnameFailureEmpty) {
      empty.call(this as UserSurnameFailureEmpty);
    }

    if (this is UserSurnameFailureInvalid) {
      invalid.call(this as UserSurnameFailureInvalid);
    }

    if (this is UserSurnameFailureTooLong) {
      tooLong.call(this as UserSurnameFailureTooLong);
    }

    if (this is UserSurnameFailureTooShort) {
      tooShort.call(this as UserSurnameFailureTooShort);
    }

    empty.call(this as UserSurnameFailureEmpty);
  }

  R map<R>({
    required R Function(UserSurnameFailureEmpty) empty,
    required R Function(UserSurnameFailureInvalid) invalid,
    required R Function(UserSurnameFailureTooLong) tooLong,
    required R Function(UserSurnameFailureTooShort) tooShort,
  }) {
    if (this is UserSurnameFailureEmpty) {
      return empty.call(this as UserSurnameFailureEmpty);
    }

    if (this is UserSurnameFailureInvalid) {
      return invalid.call(this as UserSurnameFailureInvalid);
    }

    if (this is UserSurnameFailureTooLong) {
      return tooLong.call(this as UserSurnameFailureTooLong);
    }

    if (this is UserSurnameFailureTooShort) {
      return tooShort.call(this as UserSurnameFailureTooShort);
    }

    return empty.call(this as UserSurnameFailureEmpty);
  }

  void maybeWhen({
    void Function(UserSurnameFailureEmpty)? empty,
    void Function(UserSurnameFailureInvalid)? invalid,
    void Function(UserSurnameFailureTooLong)? tooLong,
    void Function(UserSurnameFailureTooShort)? tooShort,
    required void Function() orElse,
  }) {
    if (this is UserSurnameFailureEmpty && empty != null) {
      empty.call(this as UserSurnameFailureEmpty);
    }

    if (this is UserSurnameFailureInvalid && invalid != null) {
      invalid.call(this as UserSurnameFailureInvalid);
    }

    if (this is UserSurnameFailureTooLong && tooLong != null) {
      tooLong.call(this as UserSurnameFailureTooLong);
    }

    if (this is UserSurnameFailureTooShort && tooShort != null) {
      tooShort.call(this as UserSurnameFailureTooShort);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(UserSurnameFailureEmpty)? empty,
    R Function(UserSurnameFailureInvalid)? invalid,
    R Function(UserSurnameFailureTooLong)? tooLong,
    R Function(UserSurnameFailureTooShort)? tooShort,
    required R Function() orElse,
  }) {
    if (this is UserSurnameFailureEmpty && empty != null) {
      return empty.call(this as UserSurnameFailureEmpty);
    }

    if (this is UserSurnameFailureInvalid && invalid != null) {
      return invalid.call(this as UserSurnameFailureInvalid);
    }

    if (this is UserSurnameFailureTooLong && tooLong != null) {
      return tooLong.call(this as UserSurnameFailureTooLong);
    }

    if (this is UserSurnameFailureTooShort && tooShort != null) {
      return tooShort.call(this as UserSurnameFailureTooShort);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is UserSurnameFailureEmpty) {
      return 'empty';
    }

    if (this is UserSurnameFailureInvalid) {
      return 'invalid';
    }

    if (this is UserSurnameFailureTooLong) {
      return 'tooLong';
    }

    if (this is UserSurnameFailureTooShort) {
      return 'tooShort';
    }

    return 'empty';
  }
}

class UserSurnameFailureEmpty extends UserSurnameFailure {}

class UserSurnameFailureInvalid extends UserSurnameFailure {
  UserSurnameFailureInvalid(this.value);
  final String value;
}

class UserSurnameFailureTooLong extends UserSurnameFailure {
  UserSurnameFailureTooLong(this.value);
  final String value;
}

class UserSurnameFailureTooShort extends UserSurnameFailure {
  UserSurnameFailureTooShort(this.value);
  final String value;
}
