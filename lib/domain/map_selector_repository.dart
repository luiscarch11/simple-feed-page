import 'package:dartz/dartz.dart';

import 'map_selector_failure.dart';
import 'shared/location.dart';

abstract class MapSelectorRepository {
  Future<Either<MapSelectorFailure, DomainLocation>> getUserLocation();
}
