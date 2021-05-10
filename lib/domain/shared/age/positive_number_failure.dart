import '../core/value_failure.dart';

abstract class PositiveNumberFailure extends ValueFailure {
  const PositiveNumberFailure();
  factory PositiveNumberFailure.empty() = _PositiveFailureEmpty;
  factory PositiveNumberFailure.invalid(String value) = _PositiveFailureInvalid;
  factory PositiveNumberFailure.tooSmall(int value) = _PositiveFailureTooSmall;

  void when({
    required void Function(_PositiveFailureEmpty) empty,
    required void Function(_PositiveFailureInvalid) invalid,
    required void Function(_PositiveFailureTooSmall) tooSmall,
  }) {
    if (this is _PositiveFailureEmpty) {
      empty.call(this as _PositiveFailureEmpty);
    }

    if (this is _PositiveFailureInvalid) {
      invalid.call(this as _PositiveFailureInvalid);
    }

    if (this is _PositiveFailureTooSmall) {
      tooSmall.call(this as _PositiveFailureTooSmall);
    }

    empty.call(this as _PositiveFailureEmpty);
  }

  R map<R>({
    required R Function(_PositiveFailureEmpty) empty,
    required R Function(_PositiveFailureInvalid) invalid,
    required R Function(_PositiveFailureTooSmall) tooSmall,
  }) {
    if (this is _PositiveFailureEmpty) {
      return empty.call(this as _PositiveFailureEmpty);
    }

    if (this is _PositiveFailureInvalid) {
      return invalid.call(this as _PositiveFailureInvalid);
    }

    if (this is _PositiveFailureTooSmall) {
      return tooSmall.call(this as _PositiveFailureTooSmall);
    }

    return empty.call(this as _PositiveFailureEmpty);
  }

  void maybeWhen({
    void Function(_PositiveFailureEmpty)? empty,
    void Function(_PositiveFailureInvalid)? invalid,
    void Function(_PositiveFailureTooSmall)? tooSmall,
    required void Function() orElse,
  }) {
    if (this is _PositiveFailureEmpty && empty != null) {
      empty.call(this as _PositiveFailureEmpty);
    }

    if (this is _PositiveFailureInvalid && invalid != null) {
      invalid.call(this as _PositiveFailureInvalid);
    }

    if (this is _PositiveFailureTooSmall && tooSmall != null) {
      tooSmall.call(this as _PositiveFailureTooSmall);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_PositiveFailureEmpty)? empty,
    R Function(_PositiveFailureInvalid)? invalid,
    R Function(_PositiveFailureTooSmall)? tooSmall,
    required R Function() orElse,
  }) {
    if (this is _PositiveFailureEmpty && empty != null) {
      return empty.call(this as _PositiveFailureEmpty);
    }

    if (this is _PositiveFailureInvalid && invalid != null) {
      return invalid.call(this as _PositiveFailureInvalid);
    }

    if (this is _PositiveFailureTooSmall && tooSmall != null) {
      return tooSmall.call(this as _PositiveFailureTooSmall);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is _PositiveFailureEmpty) {
      return 'empty';
    }

    if (this is _PositiveFailureInvalid) {
      return 'invalid';
    }

    if (this is _PositiveFailureTooSmall) {
      return 'tooSmall';
    }

    return 'empty';
  }
}

class _PositiveFailureEmpty extends PositiveNumberFailure {}

class _PositiveFailureInvalid extends PositiveNumberFailure {
  _PositiveFailureInvalid(this.value);
  final String value;
}

class _PositiveFailureTooSmall extends PositiveNumberFailure {
  _PositiveFailureTooSmall(this.value);
  final int value;
}
