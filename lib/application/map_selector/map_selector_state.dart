part of 'map_selector_notifier.dart';

class MapSelectorState extends Equatable {
  const MapSelectorState({
    required this.loading,
    required this.markLocation,
    required this.userLocationFailure,
    required this.userLocation,
  });
  factory MapSelectorState.initial() => MapSelectorState(
        loading: false,
        markLocation: null,
        userLocation: null,
        userLocationFailure: null,
      );
  final bool loading;
  final LatLng? markLocation;
  final MapSelectorFailure? userLocationFailure;
  final LatLng? userLocation;

  @override
  List<Object?> get props => [
        loading,
        markLocation,
        userLocation,
        userLocationFailure,
      ];

  MapSelectorState copyWith({
    bool? loading,
    LatLng? markLocation,
    LatLng? userLocation,
    Either<Unit, MapSelectorFailure>? userLocationFailure,
  }) {
    return MapSelectorState(
      userLocationFailure: userLocationFailure?.fold(
            (l) => null,
            (r) => r,
          ) ??
          this.userLocationFailure,
      loading: loading ?? this.loading,
      markLocation: markLocation ?? this.markLocation,
      userLocation: userLocation ?? this.userLocation,
    );
  }
}
