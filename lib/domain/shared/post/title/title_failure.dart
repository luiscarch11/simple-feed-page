import '../../core/value_failure.dart';

abstract class TitleFailure extends ValueFailure {
  const TitleFailure();
  factory TitleFailure.empty() = _TitleFailureEmpty;
  factory TitleFailure.tooLong(String value) = _TitleFailureTooLong;
  factory TitleFailure.tooShort(String value) = _TitleFailureTooShort;

  void when({
    required void Function(_TitleFailureEmpty) empty,
    required void Function(_TitleFailureTooLong) tooLong,
    required void Function(_TitleFailureTooShort) tooShort,
  }) {
    if (this is _TitleFailureEmpty) {
      empty.call(this as _TitleFailureEmpty);
    }

    if (this is _TitleFailureTooLong) {
      tooLong.call(this as _TitleFailureTooLong);
    }

    if (this is _TitleFailureTooShort) {
      tooShort.call(this as _TitleFailureTooShort);
    }

    empty.call(this as _TitleFailureEmpty);
  }

  R map<R>({
    required R Function(_TitleFailureEmpty) empty,
    required R Function(_TitleFailureTooLong) tooLong,
    required R Function(_TitleFailureTooShort) tooShort,
  }) {
    if (this is _TitleFailureEmpty) {
      return empty.call(this as _TitleFailureEmpty);
    }

    if (this is _TitleFailureTooLong) {
      return tooLong.call(this as _TitleFailureTooLong);
    }

    if (this is _TitleFailureTooShort) {
      return tooShort.call(this as _TitleFailureTooShort);
    }

    return empty.call(this as _TitleFailureEmpty);
  }

  void maybeWhen({
    void Function(_TitleFailureEmpty)? empty,
    void Function(_TitleFailureTooLong)? tooLong,
    void Function(_TitleFailureTooShort)? tooShort,
    required void Function() orElse,
  }) {
    if (this is _TitleFailureEmpty && empty != null) {
      empty.call(this as _TitleFailureEmpty);
    }

    if (this is _TitleFailureTooLong && tooLong != null) {
      tooLong.call(this as _TitleFailureTooLong);
    }

    if (this is _TitleFailureTooShort && tooShort != null) {
      tooShort.call(this as _TitleFailureTooShort);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_TitleFailureEmpty)? empty,
    R Function(_TitleFailureTooLong)? tooLong,
    R Function(_TitleFailureTooShort)? tooShort,
    required R Function() orElse,
  }) {
    if (this is _TitleFailureEmpty && empty != null) {
      return empty.call(this as _TitleFailureEmpty);
    }

    if (this is _TitleFailureTooLong && tooLong != null) {
      return tooLong.call(this as _TitleFailureTooLong);
    }

    if (this is _TitleFailureTooShort && tooShort != null) {
      return tooShort.call(this as _TitleFailureTooShort);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is _TitleFailureEmpty) {
      return 'empty';
    }

    if (this is _TitleFailureTooLong) {
      return 'tooLong';
    }

    if (this is _TitleFailureTooShort) {
      return 'tooShort';
    }

    return 'empty';
  }
}

class _TitleFailureEmpty extends TitleFailure {}

class _TitleFailureTooLong extends TitleFailure {
  _TitleFailureTooLong(this.value);
  final String value;
}

class _TitleFailureTooShort extends TitleFailure {
  _TitleFailureTooShort(this.value);
  final String value;
}
