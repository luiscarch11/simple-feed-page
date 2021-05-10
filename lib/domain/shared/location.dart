import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'lat_len/lat_len.dart';

class DomainLocation extends Equatable {
  const DomainLocation({
    required this.latitude,
    required this.longitude,
  });
  final LatLen latitude;
  final LatLen longitude;
  LatLng toLatLng() {
    return LatLng(
      latitude.getOrCrash(),
      longitude.getOrCrash(),
    );
  }

  DomainLocation copyWith({
    LatLen? latitude,
    LatLen? longitude,
  }) {
    return DomainLocation(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [latitude, longitude];
}
