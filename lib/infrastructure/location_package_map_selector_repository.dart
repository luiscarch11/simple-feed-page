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
      final permissionStatus = await _requestPermission();
      if (permissionStatus.isLeft())
        return left(MapSelectorFailure.permissionDenied());
      final location = await Location().getLocation();
      return right(DomainLocationDto.fromLocationData(location).toDomain());
    } catch (_) {
      return left(MapSelectorFailure.couldntGetLocation());
    }
  }

  Future<Either<MapSelectorFailure, Unit>> _requestPermission() async {
    final location = Location.instance;
    final hasPermission = await location.hasPermission();
    if (hasPermission != PermissionStatus.granted &&
        hasPermission != PermissionStatus.grantedLimited) {
      final result = await location.requestPermission();
      if (result == PermissionStatus.granted ||
          result == PermissionStatus.grantedLimited) return right(unit);
      return left(MapSelectorFailure.permissionDenied());
    }
    return right(unit);
  }
}
