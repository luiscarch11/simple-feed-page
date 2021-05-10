import '../../core/value_failure.dart';

abstract class UrlFailure extends ValueFailure {
  const UrlFailure();
  factory UrlFailure.invalid(String value) = _UrlFailureInvalid;
  factory UrlFailure.empty(String value) = _UrlFailureEmpty;

  void when({
    required void Function(_UrlFailureInvalid) invalid,
    required void Function(_UrlFailureEmpty) empty,
  }) {
    if (this is _UrlFailureInvalid) {
      invalid.call(this as _UrlFailureInvalid);
    }

    if (this is _UrlFailureEmpty) {
      empty.call(this as _UrlFailureEmpty);
    }

    invalid.call(this as _UrlFailureInvalid);
  }

  R map<R>({
    required R Function(_UrlFailureInvalid) invalid,
    required R Function(_UrlFailureEmpty) empty,
  }) {
    if (this is _UrlFailureInvalid) {
      return invalid.call(this as _UrlFailureInvalid);
    }

    if (this is _UrlFailureEmpty) {
      return empty.call(this as _UrlFailureEmpty);
    }

    return invalid.call(this as _UrlFailureInvalid);
  }

  void maybeWhen({
    void Function(_UrlFailureInvalid)? invalid,
    void Function(_UrlFailureEmpty)? empty,
    required void Function() orElse,
  }) {
    if (this is _UrlFailureInvalid && invalid != null) {
      invalid.call(this as _UrlFailureInvalid);
    }

    if (this is _UrlFailureEmpty && empty != null) {
      empty.call(this as _UrlFailureEmpty);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_UrlFailureInvalid)? invalid,
    R Function(_UrlFailureEmpty)? empty,
    required R Function() orElse,
  }) {
    if (this is _UrlFailureInvalid && invalid != null) {
      return invalid.call(this as _UrlFailureInvalid);
    }

    if (this is _UrlFailureEmpty && empty != null) {
      return empty.call(this as _UrlFailureEmpty);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is _UrlFailureInvalid) {
      return 'invalid';
    }

    if (this is _UrlFailureEmpty) {
      return 'empty';
    }

    return 'invalid';
  }
}

class _UrlFailureInvalid extends UrlFailure {
  _UrlFailureInvalid(this.value);
  final String value;
}

class _UrlFailureEmpty extends UrlFailure {
  _UrlFailureEmpty(this.value);
  final String value;
}
