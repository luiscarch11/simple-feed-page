import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/map_selector_failure.dart';
import '../../domain/map_selector_repository.dart';

part 'map_selector_state.dart';

class MapSelectorNotifier extends StateNotifier<MapSelectorState> {
  MapSelectorNotifier(this._mapSelectorRepository)
      : super(MapSelectorState.initial());
  final MapSelectorRepository _mapSelectorRepository;
  Future<void> init() async {
    state = state.copyWith(
      loading: true,
    );
    final locationOrFailure = await _mapSelectorRepository.getUserLocation();

    locationOrFailure.fold(
      (l) => state = state.copyWith(
        userLocationFailure: l,
        loading: false,
      ),
      (r) {
        final latitude = r.latitude;
        final longitude = r.longitude;
        state = state.copyWith(
          loading: false,
          userLocation: LatLng(
            latitude.getOrCrash(),
            longitude.getOrCrash(),
          ),
        );
      },
    );
  }

  void changeMarkLocation(LatLng newLocation) {
    state = state.copyWith(markLocation: newLocation);
  }
}
