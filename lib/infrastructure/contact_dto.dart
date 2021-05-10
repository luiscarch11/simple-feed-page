import '../domain/shared/contact.dart';
import '../domain/shared/relationship/relationship.dart';
import 'user_dto.dart';

class ContactDto {
  const ContactDto._({
    required this.user,
    required this.relationship,
  });
  final UserDto user;
  final String relationship;

  static ContactDto fromJson(Map<String, dynamic> json) {
    return ContactDto._(
      user: UserDto.fromJson(json['user']),
      relationship: json['relationship'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'relationship': relationship,
    };
  }

  static ContactDto fromDomain(Contact domain) {
    return ContactDto._(
      user: UserDto.fromDomain(domain.user),
      relationship: domain.relationship.getString(),
    );
  }

  Contact toDomain() {
    return Contact(
      user: this.user.toDomain(),
      relationship: Relationship.fromString(this.relationship),
    );
  }
}
