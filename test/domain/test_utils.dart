import 'package:events_feed/domain/shared/lat_len/lat_len.dart';
import 'package:events_feed/domain/shared/location.dart';
import 'package:events_feed/domain/shared/unique_id/unique_id.dart';
import 'package:events_feed/domain/shared/user.dart';
import 'package:events_feed/domain/shared/user_name/user_name.dart';
import 'package:events_feed/domain/shared/user_surname/user_surname.dart';

class TestUtils {
  static DomainLocation get anyLocation => DomainLocation(
        latitude: LatLen('-32'),
        longitude: LatLen('-32'),
      );

  static User get anyUser => User(
        id: UniqueId(),
        name: anyUserName,
        surname: anyUserSurname,
        birthDate: DateTime.now(),
        location: anyLocation,
        interests: [],
        contacts: [],
      );
  static UserName get anyUserName => UserName('input');
  static UserSurname get anyUserSurname => UserSurname('anyusername');
}
