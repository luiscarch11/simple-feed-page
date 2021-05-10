import '../../domain/shared/interest/interest.dart';
import '../../domain/shared/interest/interest_name/interest_name.dart';
import '../../domain/shared/unique_id/unique_id.dart';

class InterestDto {
  const InterestDto._({
    required this.id,
    required this.name,
  });
  final String id;
  final String name;

  static InterestDto fromJson(Map<String, dynamic> json) {
    return InterestDto._(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  static InterestDto fromDomain(Interest domain) {
    return InterestDto._(
      id: domain.id.getOrCrash(),
      name: domain.name.getOrCrash(),
    );
  }

  Interest toDomain() {
    return Interest(
      id: UniqueId.fromString(this.id),
      name: InterestName(this.name),
    );
  }
}
