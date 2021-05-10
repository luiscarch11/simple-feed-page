import '../core/value_failure.dart';

abstract class UniqueIdFailure extends ValueFailure {
  const UniqueIdFailure();
  factory UniqueIdFailure.empty() = UniqueIdFailureEmpty;

  void when({
    required void Function(UniqueIdFailureEmpty) empty,
  }) {
    if (this is UniqueIdFailureEmpty) {
      empty.call(this as UniqueIdFailureEmpty);
    }

    empty.call(this as UniqueIdFailureEmpty);
  }

  R map<R>({
    required R Function(UniqueIdFailureEmpty) empty,
  }) {
    if (this is UniqueIdFailureEmpty) {
      return empty.call(this as UniqueIdFailureEmpty);
    }

    return empty.call(this as UniqueIdFailureEmpty);
  }

  void maybeWhen({
    void Function(UniqueIdFailureEmpty)? empty,
    required void Function() orElse,
  }) {
    if (this is UniqueIdFailureEmpty && empty != null) {
      empty.call(this as UniqueIdFailureEmpty);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(UniqueIdFailureEmpty)? empty,
    required R Function() orElse,
  }) {
    if (this is UniqueIdFailureEmpty && empty != null) {
      return empty.call(this as UniqueIdFailureEmpty);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is UniqueIdFailureEmpty) {
      return 'empty';
    }

    return 'empty';
  }
}

class UniqueIdFailureEmpty extends UniqueIdFailure {}
