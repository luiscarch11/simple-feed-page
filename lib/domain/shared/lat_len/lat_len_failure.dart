import '../core/value_failure.dart';

abstract class LatLenFailure extends ValueFailure {
  const LatLenFailure();
  factory LatLenFailure.invalid(String value) = _LatLenFailureInvalid;

  void when({
    required void Function(_LatLenFailureInvalid) invalid,
  }) {
    if (this is _LatLenFailureInvalid) {
      invalid.call(this as _LatLenFailureInvalid);
    }

    invalid.call(this as _LatLenFailureInvalid);
  }

  R map<R>({
    required R Function(_LatLenFailureInvalid) invalid,
  }) {
    if (this is _LatLenFailureInvalid) {
      return invalid.call(this as _LatLenFailureInvalid);
    }

    return invalid.call(this as _LatLenFailureInvalid);
  }

  void maybeWhen({
    void Function(_LatLenFailureInvalid)? invalid,
    required void Function() orElse,
  }) {
    if (this is _LatLenFailureInvalid && invalid != null) {
      invalid.call(this as _LatLenFailureInvalid);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_LatLenFailureInvalid)? invalid,
    required R Function() orElse,
  }) {
    if (this is _LatLenFailureInvalid && invalid != null) {
      return invalid.call(this as _LatLenFailureInvalid);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is _LatLenFailureInvalid) {
      return 'invalid';
    }

    return 'invalid';
  }
}

class _LatLenFailureInvalid extends LatLenFailure {
  _LatLenFailureInvalid(this.value);
  final String value;
}
