import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

import '../domain/add_content_form_failure.dart';
import '../domain/add_content_form_repository.dart';
import '../domain/shared/age/positive_number.dart';
import '../domain/shared/post/description/description.dart';
import '../domain/shared/post/title/title.dart';
import '../domain/shared/unique_id/unique_id.dart';
import '../domain/shared/user.dart';
import 'user_dto.dart';

class FirestoreAddContentFormRepository implements AddContentFormRepository {
  @override
  Future<Either<AddContentFormFailure, UniqueId>> insertNewContent({
    required DateTime eventDate,
    required Title title,
    required Description description,
    required LatLng location,
    required PositiveNumber maximumPeople,
    required User currentUser,
  }) async {
    final data = <String, dynamic>{
      'id': UniqueId().getOrCrash(),
      'title': title.getOrCrash(),
      'description': description.getOrCrash(),
      'publisher': UserDto.fromDomain(currentUser).toJson(),
      'date': eventDate.millisecondsSinceEpoch,
      'maximumPeople': maximumPeople.getOrCrash(),
      'location': {
        'latitude': location.latitude.toString(),
        'longitude': location.longitude.toString(),
      },
      'assistants': [],
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    };
    try {
      final id = await _firestore.collection('events').add(data).then((value) {
        value.set(
          {
            'id': value.id,
          },
          SetOptions(
            merge: true,
          ),
        );
        return value.id;
      });
      return right(UniqueId.fromString(id));
    } catch (e) {
      return left(AddContentFormFailure.serverError());
    }
  }

  @override
  Future<Either<AddContentFormFailure, Unit>> editContent({
    required UniqueId id,
    required DateTime eventDate,
    required Title title,
    required PositiveNumber maximumPeople,
    required Description description,
    required LatLng location,
  }) async {
    final data = {
      'title': title.getOrCrash(),
      'description': description.getOrCrash(),
      'date': eventDate.millisecondsSinceEpoch,
      'maximumPeople': maximumPeople.getOrCrash(),
      'location': {
        'latitude': location.latitude.toString(),
        'longitude': location.longitude.toString(),
      },
    };
    try {
      await _firestore.collection('events').doc(id.getOrCrash()).set(
            data,
            SetOptions(
              merge: true,
            ),
          );
      return right(unit);
    } catch (_) {
      return left(AddContentFormFailure.serverError());
    }
  }

  FirebaseFirestore get _firestore => FirebaseFirestore.instance;
}
