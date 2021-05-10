import 'package:dartz/dartz.dart';
import 'package:location/location.dart';

import '../domain/map_selector_failure.dart';
import '../domain/map_selector_repository.dart';
import '../domain/shared/location.dart';
import 'location/domain_location_dto.dart';

class LocationPackageMapSelectorRepository implements MapSelectorRepository {
  @override
  Future<Either<MapSelectorFailure, DomainLocation>> getUserLocation() async {
    try {
      final location = await Location().getLocation();
      return right(DomainLocationDto.fromLocationData(location).toDomain());
    } catch (_) {
      return left(MapSelectorFailure.couldntGetLocation());
    }
  }
}
