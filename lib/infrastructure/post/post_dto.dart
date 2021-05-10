import '../../domain/shared/post/description/description.dart';
import '../../domain/shared/post/post.dart';
import '../../domain/shared/post/title/title.dart';
import '../../domain/shared/unique_id/unique_id.dart';
import '../user_dto.dart';

class PostDto {
  const PostDto._({
    required this.id,
    required this.title,
    required this.publisher,
    required this.description,
    required this.createdAt,
  });
  final String id;
  final String title;
  final int createdAt;
  final UserDto publisher;
  final String description;

  static PostDto fromJson(Map<String, dynamic> json) {
    return PostDto._(
      id: json['id'],
      createdAt: json['createdAt'],
      title: json['title'],
      publisher: UserDto.fromJson(json['publisher']),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'title': title,
      'publisher': publisher,
      'description': description,
    };
  }

  static PostDto fromDomain(Post domain) {
    return PostDto._(
      createdAt: domain.createdAt.millisecondsSinceEpoch,
      id: domain.id.getOrCrash(),
      title: domain.title.getOrCrash(),
      publisher: UserDto.fromDomain(domain.publisher),
      description: domain.description.getOrCrash(),
    );
  }

  Post toDomain() {
    return Post(
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      id: UniqueId.fromString(this.id),
      title: Title(this.title),
      publisher: this.publisher.toDomain(),
      description: Description(this.description),
    );
  }
}
