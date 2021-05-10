import 'package:equatable/equatable.dart';

import 'contact.dart';
import 'interest/interest.dart';
import 'location.dart';
import 'unique_id/unique_id.dart';
import 'user_name/user_name.dart';
import 'user_surname/user_surname.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.surname,
    required this.birthDate,
    required this.location,
    required this.interests,
    required this.contacts,
  });
  final UniqueId id;
  final UserName name;
  final UserSurname surname;
  final DateTime birthDate;
  final DomainLocation location;
  final List<Interest> interests;
  final List<Contact> contacts;

  @override
  List<Object> get props {
    return [
      id,
      name,
      surname,
      birthDate,
      location,
      interests,
      contacts,
    ];
  }

  User copyWith({
    UniqueId? id,
    UserName? name,
    UserSurname? surname,
    DateTime? birthDate,
    DomainLocation? location,
    List<Interest>? interests,
    List<Contact>? contacts,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      birthDate: birthDate ?? this.birthDate,
      location: location ?? this.location,
      interests: interests ?? this.interests,
      contacts: contacts ?? this.contacts,
    );
  }
}
