import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/shared/lat_len/lat_len.dart';
import '../../domain/shared/location.dart';
import '../../domain/shared/unique_id/unique_id.dart';
import '../../domain/shared/user.dart';
import '../../domain/shared/user_name/user_name.dart';
import '../../domain/shared/user_surname/user_surname.dart';

part 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier()
      : super(
          AuthState.authenticated(
            User(
              birthDate: DateTime.parse('1998-05-04'),
              contacts: [],
              id: UniqueId.fromString('1346479asdasd'),
              name: UserName('Luis'),
              surname: UserSurname('Utrera'),
              interests: [],
              location: DomainLocation(
                latitude: LatLen('0'),
                longitude: LatLen('0'),
              ),
            ),
          ),
        );
  User? get currentUser => state.map(
        initial: (_) => null,
        authenticated: (auth) => auth.user,
      );
}
