abstract class MapSelectorFailure {
  const MapSelectorFailure();
  factory MapSelectorFailure.couldntGetLocation() =
      _MapSelectorFailureCouldntGetLocation;
  factory MapSelectorFailure.permissionDenied() =
      _MapSelectorFailurePermissionDenied;

  void when({
    required void Function(_MapSelectorFailureCouldntGetLocation)
        couldntGetLocation,
    required void Function(_MapSelectorFailurePermissionDenied)
        permissionDenied,
  }) {
    if (this is _MapSelectorFailureCouldntGetLocation) {
      couldntGetLocation.call(this as _MapSelectorFailureCouldntGetLocation);
    }

    if (this is _MapSelectorFailurePermissionDenied) {
      permissionDenied.call(this as _MapSelectorFailurePermissionDenied);
    }

    couldntGetLocation.call(this as _MapSelectorFailureCouldntGetLocation);
  }

  R map<R>({
    required R Function(_MapSelectorFailureCouldntGetLocation)
        couldntGetLocation,
    required R Function(_MapSelectorFailurePermissionDenied) permissionDenied,
  }) {
    if (this is _MapSelectorFailureCouldntGetLocation) {
      return couldntGetLocation
          .call(this as _MapSelectorFailureCouldntGetLocation);
    }

    if (this is _MapSelectorFailurePermissionDenied) {
      return permissionDenied.call(this as _MapSelectorFailurePermissionDenied);
    }

    return couldntGetLocation
        .call(this as _MapSelectorFailureCouldntGetLocation);
  }

  void maybeWhen({
    void Function(_MapSelectorFailureCouldntGetLocation)? couldntGetLocation,
    void Function(_MapSelectorFailurePermissionDenied)? permissionDenied,
    required void Function() orElse,
  }) {
    if (this is _MapSelectorFailureCouldntGetLocation &&
        couldntGetLocation != null) {
      couldntGetLocation.call(this as _MapSelectorFailureCouldntGetLocation);
    }

    if (this is _MapSelectorFailurePermissionDenied &&
        permissionDenied != null) {
      permissionDenied.call(this as _MapSelectorFailurePermissionDenied);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_MapSelectorFailureCouldntGetLocation)? couldntGetLocation,
    R Function(_MapSelectorFailurePermissionDenied)? permissionDenied,
    required R Function() orElse,
  }) {
    if (this is _MapSelectorFailureCouldntGetLocation &&
        couldntGetLocation != null) {
      return couldntGetLocation
          .call(this as _MapSelectorFailureCouldntGetLocation);
    }

    if (this is _MapSelectorFailurePermissionDenied &&
        permissionDenied != null) {
      return permissionDenied.call(this as _MapSelectorFailurePermissionDenied);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is _MapSelectorFailureCouldntGetLocation) {
      return 'couldntGetLocation';
    }

    if (this is _MapSelectorFailurePermissionDenied) {
      return 'permissionDenied';
    }

    return 'couldntGetLocation';
  }
}

class _MapSelectorFailureCouldntGetLocation extends MapSelectorFailure {}

class _MapSelectorFailurePermissionDenied extends MapSelectorFailure {}
