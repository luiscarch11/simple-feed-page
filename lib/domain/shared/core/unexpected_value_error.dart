import 'value_failure.dart';

class UnexpectedValueError<F extends ValueFailure> extends Error {
  UnexpectedValueError(this.failure);
  final F failure;
  @override
  String toString() {
    const explanation =
        'Encountered a ValueFailure at an unrecoverable point. Terminating.';
    return Error.safeToString('$explanation Failure was: $failure');
  }
}
