import 'package:location/location.dart';

import '../../domain/shared/lat_len/lat_len.dart';
import '../../domain/shared/location.dart';

class DomainLocationDto {
  const DomainLocationDto._({
    required this.latitude,
    required this.longitude,
  });
  final double latitude;
  final double longitude;

  static DomainLocationDto fromJson(Map<String, dynamic> json) {
    return DomainLocationDto._(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  static DomainLocationDto fromLocationData(LocationData locationData) {
    return DomainLocationDto._(
      latitude: locationData.latitude!,
      longitude: locationData.longitude!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  static DomainLocationDto fromDomain(DomainLocation domain) {
    return DomainLocationDto._(
      latitude: domain.latitude.getOrCrash(),
      longitude: domain.longitude.getOrCrash(),
    );
  }

  DomainLocation toDomain() {
    return DomainLocation(
      latitude: LatLen(this.latitude.toString()),
      longitude: LatLen(this.longitude.toString()),
    );
  }
}
