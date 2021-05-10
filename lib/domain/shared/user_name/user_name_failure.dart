import '../core/value_failure.dart';

abstract class UserNameFailure extends ValueFailure {
  const UserNameFailure();
  factory UserNameFailure.empty() = _UserNameFailureEmpty;
  factory UserNameFailure.invalid(String value) = _UserNameFailureInvalid;
  factory UserNameFailure.tooLong(String value) = _UserNameFailureTooLong;
  factory UserNameFailure.tooShort(String value) = _UserNameFailureTooShort;

  void when({
    required void Function(_UserNameFailureEmpty) empty,
    required void Function(_UserNameFailureInvalid) invalid,
    required void Function(_UserNameFailureTooLong) tooLong,
    required void Function(_UserNameFailureTooShort) tooShort,
  }) {
    if (this is _UserNameFailureEmpty) {
      empty.call(this as _UserNameFailureEmpty);
    }

    if (this is _UserNameFailureInvalid) {
      invalid.call(this as _UserNameFailureInvalid);
    }

    if (this is _UserNameFailureTooLong) {
      tooLong.call(this as _UserNameFailureTooLong);
    }

    if (this is _UserNameFailureTooShort) {
      tooShort.call(this as _UserNameFailureTooShort);
    }

    empty.call(this as _UserNameFailureEmpty);
  }

  R map<R>({
    required R Function(_UserNameFailureEmpty) empty,
    required R Function(_UserNameFailureInvalid) invalid,
    required R Function(_UserNameFailureTooLong) tooLong,
    required R Function(_UserNameFailureTooShort) tooShort,
  }) {
    if (this is _UserNameFailureEmpty) {
      return empty.call(this as _UserNameFailureEmpty);
    }

    if (this is _UserNameFailureInvalid) {
      return invalid.call(this as _UserNameFailureInvalid);
    }

    if (this is _UserNameFailureTooLong) {
      return tooLong.call(this as _UserNameFailureTooLong);
    }

    if (this is _UserNameFailureTooShort) {
      return tooShort.call(this as _UserNameFailureTooShort);
    }

    return empty.call(this as _UserNameFailureEmpty);
  }

  void maybeWhen({
    void Function(_UserNameFailureEmpty)? empty,
    void Function(_UserNameFailureInvalid)? invalid,
    void Function(_UserNameFailureTooLong)? tooLong,
    void Function(_UserNameFailureTooShort)? tooShort,
    required void Function() orElse,
  }) {
    if (this is _UserNameFailureEmpty && empty != null) {
      empty.call(this as _UserNameFailureEmpty);
    }

    if (this is _UserNameFailureInvalid && invalid != null) {
      invalid.call(this as _UserNameFailureInvalid);
    }

    if (this is _UserNameFailureTooLong && tooLong != null) {
      tooLong.call(this as _UserNameFailureTooLong);
    }

    if (this is _UserNameFailureTooShort && tooShort != null) {
      tooShort.call(this as _UserNameFailureTooShort);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_UserNameFailureEmpty)? empty,
    R Function(_UserNameFailureInvalid)? invalid,
    R Function(_UserNameFailureTooLong)? tooLong,
    R Function(_UserNameFailureTooShort)? tooShort,
    required R Function() orElse,
  }) {
    if (this is _UserNameFailureEmpty && empty != null) {
      return empty.call(this as _UserNameFailureEmpty);
    }

    if (this is _UserNameFailureInvalid && invalid != null) {
      return invalid.call(this as _UserNameFailureInvalid);
    }

    if (this is _UserNameFailureTooLong && tooLong != null) {
      return tooLong.call(this as _UserNameFailureTooLong);
    }

    if (this is _UserNameFailureTooShort && tooShort != null) {
      return tooShort.call(this as _UserNameFailureTooShort);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is _UserNameFailureEmpty) {
      return 'empty';
    }

    if (this is _UserNameFailureInvalid) {
      return 'invalid';
    }

    if (this is _UserNameFailureTooLong) {
      return 'tooLong';
    }

    if (this is _UserNameFailureTooShort) {
      return 'tooShort';
    }

    return 'empty';
  }
}

class _UserNameFailureEmpty extends UserNameFailure {}

class _UserNameFailureInvalid extends UserNameFailure {
  _UserNameFailureInvalid(this.value);
  final String value;
}

class _UserNameFailureTooLong extends UserNameFailure {
  _UserNameFailureTooLong(this.value);
  final String value;
}

class _UserNameFailureTooShort extends UserNameFailure {
  _UserNameFailureTooShort(this.value);
  final String value;
}
