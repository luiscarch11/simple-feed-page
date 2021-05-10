import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'add_content_form_failure.dart';
import 'shared/age/positive_number.dart';
import 'shared/post/description/description.dart';
import 'shared/post/title/title.dart';
import 'shared/unique_id/unique_id.dart';
import 'shared/user.dart';

abstract class AddContentFormRepository {
  Future<Either<AddContentFormFailure, UniqueId>> insertNewContent({
    required DateTime eventDate,
    required Title title,
    required Description description,
    required LatLng location,
    required User currentUser,
    required PositiveNumber maximumPeople,
  });
  Future<Either<AddContentFormFailure, Unit>> editContent({
    required UniqueId id,
    required DateTime eventDate,
    required Title title,
    required Description description,
    required LatLng location,
    required PositiveNumber maximumPeople,
  });
}
