import '../domain/shared/lat_len/lat_len.dart';
import '../domain/shared/location.dart';

class LocationDto {
  const LocationDto._({
    required this.latitude,
    required this.longitude,
  });
  final String latitude;
  final String longitude;

  static LocationDto fromJson(Map<String, dynamic> json) {
    return LocationDto._(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  static LocationDto fromDomain(DomainLocation domain) {
    return LocationDto._(
      latitude: domain.latitude.getOrCrash().toString(),
      longitude: domain.longitude.getOrCrash().toString(),
    );
  }

  DomainLocation toDomain() {
    return DomainLocation(
      latitude: LatLen(this.latitude),
      longitude: LatLen(this.longitude),
    );
  }
}
