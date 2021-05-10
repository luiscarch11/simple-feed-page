import '../../core/value_failure.dart';

abstract class DescriptionFailure extends ValueFailure {
  const DescriptionFailure();
  factory DescriptionFailure.tooShort(String value) =
      _DescriptionFailureTooShort;
  factory DescriptionFailure.tooLong(String value) = _DescriptionFailureTooLong;
  factory DescriptionFailure.empty() = _DescriptionFailureEmpty;

  void when({
    required void Function(_DescriptionFailureTooShort) tooShort,
    required void Function(_DescriptionFailureTooLong) tooLong,
    required void Function(_DescriptionFailureEmpty) empty,
  }) {
    if (this is _DescriptionFailureTooShort) {
      tooShort.call(this as _DescriptionFailureTooShort);
    }

    if (this is _DescriptionFailureTooLong) {
      tooLong.call(this as _DescriptionFailureTooLong);
    }

    if (this is _DescriptionFailureEmpty) {
      empty.call(this as _DescriptionFailureEmpty);
    }

    tooShort.call(this as _DescriptionFailureTooShort);
  }

  R map<R>({
    required R Function(_DescriptionFailureTooShort) tooShort,
    required R Function(_DescriptionFailureTooLong) tooLong,
    required R Function(_DescriptionFailureEmpty) empty,
  }) {
    if (this is _DescriptionFailureTooShort) {
      return tooShort.call(this as _DescriptionFailureTooShort);
    }

    if (this is _DescriptionFailureTooLong) {
      return tooLong.call(this as _DescriptionFailureTooLong);
    }

    if (this is _DescriptionFailureEmpty) {
      return empty.call(this as _DescriptionFailureEmpty);
    }

    return tooShort.call(this as _DescriptionFailureTooShort);
  }

  void maybeWhen({
    void Function(_DescriptionFailureTooShort)? tooShort,
    void Function(_DescriptionFailureTooLong)? tooLong,
    void Function(_DescriptionFailureEmpty)? empty,
    required void Function() orElse,
  }) {
    if (this is _DescriptionFailureTooShort && tooShort != null) {
      tooShort.call(this as _DescriptionFailureTooShort);
    }

    if (this is _DescriptionFailureTooLong && tooLong != null) {
      tooLong.call(this as _DescriptionFailureTooLong);
    }

    if (this is _DescriptionFailureEmpty && empty != null) {
      empty.call(this as _DescriptionFailureEmpty);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_DescriptionFailureTooShort)? tooShort,
    R Function(_DescriptionFailureTooLong)? tooLong,
    R Function(_DescriptionFailureEmpty)? empty,
    required R Function() orElse,
  }) {
    if (this is _DescriptionFailureTooShort && tooShort != null) {
      return tooShort.call(this as _DescriptionFailureTooShort);
    }

    if (this is _DescriptionFailureTooLong && tooLong != null) {
      return tooLong.call(this as _DescriptionFailureTooLong);
    }

    if (this is _DescriptionFailureEmpty && empty != null) {
      return empty.call(this as _DescriptionFailureEmpty);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is _DescriptionFailureTooShort) {
      return 'tooShort';
    }

    if (this is _DescriptionFailureTooLong) {
      return 'tooLong';
    }

    if (this is _DescriptionFailureEmpty) {
      return 'empty';
    }

    return 'tooShort';
  }
}

class _DescriptionFailureTooShort extends DescriptionFailure {
  _DescriptionFailureTooShort(this.value);
  final String value;
}

class _DescriptionFailureTooLong extends DescriptionFailure {
  _DescriptionFailureTooLong(this.value);
  final String value;
}

class _DescriptionFailureEmpty extends DescriptionFailure {
  const _DescriptionFailureEmpty();
}
