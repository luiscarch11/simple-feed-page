import '../../core/value_failure.dart';

abstract class InterestNameFailure extends ValueFailure {
  const InterestNameFailure();
  factory InterestNameFailure.empty() = _InterestNameFailureEmpty;
  factory InterestNameFailure.invalid(String value) =
      _InterestNameFailureInvalid;
  factory InterestNameFailure.tooLong(String value) =
      _InterestNameFailureTooLong;

  void when({
    required void Function(_InterestNameFailureEmpty) empty,
    required void Function(_InterestNameFailureInvalid) invalid,
    required void Function(_InterestNameFailureTooLong) tooLong,
  }) {
    if (this is _InterestNameFailureEmpty) {
      empty.call(this as _InterestNameFailureEmpty);
    }

    if (this is _InterestNameFailureInvalid) {
      invalid.call(this as _InterestNameFailureInvalid);
    }

    if (this is _InterestNameFailureTooLong) {
      tooLong.call(this as _InterestNameFailureTooLong);
    }

    empty.call(this as _InterestNameFailureEmpty);
  }

  R map<R>({
    required R Function(_InterestNameFailureEmpty) empty,
    required R Function(_InterestNameFailureInvalid) invalid,
    required R Function(_InterestNameFailureTooLong) tooLong,
  }) {
    if (this is _InterestNameFailureEmpty) {
      return empty.call(this as _InterestNameFailureEmpty);
    }

    if (this is _InterestNameFailureInvalid) {
      return invalid.call(this as _InterestNameFailureInvalid);
    }

    if (this is _InterestNameFailureTooLong) {
      return tooLong.call(this as _InterestNameFailureTooLong);
    }

    return empty.call(this as _InterestNameFailureEmpty);
  }

  void maybeWhen({
    void Function(_InterestNameFailureEmpty)? empty,
    void Function(_InterestNameFailureInvalid)? invalid,
    void Function(_InterestNameFailureTooLong)? tooLong,
    required void Function() orElse,
  }) {
    if (this is _InterestNameFailureEmpty && empty != null) {
      empty.call(this as _InterestNameFailureEmpty);
    }

    if (this is _InterestNameFailureInvalid && invalid != null) {
      invalid.call(this as _InterestNameFailureInvalid);
    }

    if (this is _InterestNameFailureTooLong && tooLong != null) {
      tooLong.call(this as _InterestNameFailureTooLong);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_InterestNameFailureEmpty)? empty,
    R Function(_InterestNameFailureInvalid)? invalid,
    R Function(_InterestNameFailureTooLong)? tooLong,
    required R Function() orElse,
  }) {
    if (this is _InterestNameFailureEmpty && empty != null) {
      return empty.call(this as _InterestNameFailureEmpty);
    }

    if (this is _InterestNameFailureInvalid && invalid != null) {
      return invalid.call(this as _InterestNameFailureInvalid);
    }

    if (this is _InterestNameFailureTooLong && tooLong != null) {
      return tooLong.call(this as _InterestNameFailureTooLong);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is _InterestNameFailureEmpty) {
      return 'empty';
    }

    if (this is _InterestNameFailureInvalid) {
      return 'invalid';
    }

    if (this is _InterestNameFailureTooLong) {
      return 'tooLong';
    }

    return 'empty';
  }
}

class _InterestNameFailureEmpty extends InterestNameFailure {}

class _InterestNameFailureInvalid extends InterestNameFailure {
  _InterestNameFailureInvalid(this.value);
  final String value;
}

class _InterestNameFailureTooLong extends InterestNameFailure {
  _InterestNameFailureTooLong(this.value);
  final String value;
}
