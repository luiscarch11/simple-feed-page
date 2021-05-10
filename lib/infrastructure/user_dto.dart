import '../domain/shared/unique_id/unique_id.dart';
import '../domain/shared/user.dart';
import '../domain/shared/user_name/user_name.dart';
import '../domain/shared/user_surname/user_surname.dart';
import 'contact_dto.dart';
import 'interest/interest_dto.dart';
import 'location_dto.dart';

class UserDto {
  const UserDto._({
    required this.id,
    required this.name,
    required this.surname,
    required this.birthDate,
    required this.location,
    required this.interests,
    required this.contacts,
  });
  final String id;
  final String name;
  final String surname;
  final int birthDate;
  final LocationDto location;
  final List<InterestDto> interests;
  final List<ContactDto> contacts;

  static UserDto fromJson(Map<String, dynamic> json) {
    return UserDto._(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      birthDate: json['birthDate'],
      location: LocationDto.fromJson(json['location']),
      interests: (json['interests'] as List)
          .map((e) => InterestDto.fromJson(e))
          .toList(),
      contacts: (json['contacts'] as List)
          .map((e) => ContactDto.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'birthDate': birthDate,
      'location': location.toJson(),
      'interests': interests
          .map(
            (e) => e.toJson(),
          )
          .toList(),
      'contacts': contacts
          .map(
            (e) => e.toJson(),
          )
          .toList(),
    };
  }

  static UserDto fromDomain(User domain) {
    return UserDto._(
      id: domain.id.getOrCrash(),
      name: domain.name.getOrCrash(),
      surname: domain.surname.getOrCrash(),
      birthDate: domain.birthDate.millisecondsSinceEpoch,
      location: LocationDto.fromDomain(domain.location),
      interests:
          domain.interests.map((e) => InterestDto.fromDomain(e)).toList(),
      contacts: domain.contacts.map((e) => ContactDto.fromDomain(e)).toList(),
    );
  }

  User toDomain() {
    return User(
      id: UniqueId.fromString(this.id),
      name: UserName(this.name),
      surname: UserSurname(this.surname),
      birthDate: DateTime.fromMillisecondsSinceEpoch(this.birthDate),
      location: this.location.toDomain(),
      interests: this
          .interests
          .map(
            (e) => e.toDomain(),
          )
          .toList(),
      contacts: this
          .contacts
          .map(
            (e) => e.toDomain(),
          )
          .toList(),
    );
  }
}
