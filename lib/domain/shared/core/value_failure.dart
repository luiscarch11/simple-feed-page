abstract class ValueFailure {
  const ValueFailure();
  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is ValueFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}
