abstract class MapSelectorFailure {
  const MapSelectorFailure();
  factory MapSelectorFailure.couldntGetLocation() =
      _MapSelectorFailureCouldntGetLocation;

  void when({
    required void Function(_MapSelectorFailureCouldntGetLocation)
        couldntGetLocation,
  }) {
    if (this is _MapSelectorFailureCouldntGetLocation) {
      couldntGetLocation.call(this as _MapSelectorFailureCouldntGetLocation);
    }

    couldntGetLocation.call(this as _MapSelectorFailureCouldntGetLocation);
  }

  R map<R>({
    required R Function(_MapSelectorFailureCouldntGetLocation)
        couldntGetLocation,
  }) {
    if (this is _MapSelectorFailureCouldntGetLocation) {
      return couldntGetLocation
          .call(this as _MapSelectorFailureCouldntGetLocation);
    }

    return couldntGetLocation
        .call(this as _MapSelectorFailureCouldntGetLocation);
  }

  void maybeWhen({
    void Function(_MapSelectorFailureCouldntGetLocation)? couldntGetLocation,
    required void Function() orElse,
  }) {
    if (this is _MapSelectorFailureCouldntGetLocation &&
        couldntGetLocation != null) {
      couldntGetLocation.call(this as _MapSelectorFailureCouldntGetLocation);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_MapSelectorFailureCouldntGetLocation)? couldntGetLocation,
    required R Function() orElse,
  }) {
    if (this is _MapSelectorFailureCouldntGetLocation &&
        couldntGetLocation != null) {
      return couldntGetLocation
          .call(this as _MapSelectorFailureCouldntGetLocation);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is _MapSelectorFailureCouldntGetLocation) {
      return 'couldntGetLocation';
    }

    return 'couldntGetLocation';
  }
}

class _MapSelectorFailureCouldntGetLocation extends MapSelectorFailure {}
