import '../../domain/shared/post/novelty_post.dart';
import '../../domain/shared/unique_id/unique_id.dart';
import 'event_post_dto.dart';
import 'post_dto.dart';

class NoveltyPostDto {
  const NoveltyPostDto._({
    required this.id,
    required this.post,
    required this.relatedEvent,
  });
  final PostDto post;
  final String id;
  final EventPostDto? relatedEvent;

  static NoveltyPostDto fromJson(Map<String, dynamic> json) {
    return NoveltyPostDto._(
      post: json['post'],
      id: json['id'],
      relatedEvent: json['relatedEvent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'post': post,
      'id': id,
      'relatedEvent': relatedEvent,
    };
  }

  static NoveltyPostDto fromDomain(NoveltyPost domain) {
    return NoveltyPostDto._(
      id: domain.id.getOrCrash(),
      post: PostDto.fromDomain(domain.post),
      relatedEvent: domain.relatedEvent == null
          ? null
          : EventPostDto.fromDomain(domain.relatedEvent!),
    );
  }

  NoveltyPost toDomain() {
    return NoveltyPost(
      id: UniqueId.fromString(this.id),
      post: this.post.toDomain(),
      relatedEvent: this.relatedEvent?.toDomain(),
    );
  }
}
