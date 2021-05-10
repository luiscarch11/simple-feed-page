import 'package:equatable/equatable.dart';

import '../unique_id/unique_id.dart';
import 'event_post.dart';
import 'post.dart';

class NoveltyPost with EquatableMixin {
  const NoveltyPost({
    required this.post,
    required this.id,
    this.relatedEvent,
  });
  final Post post;
  final UniqueId id;
  final EventPost? relatedEvent;

  @override
  List<Object> get props => [
        post,
        id,
        relatedEvent!,
      ];

  NoveltyPost copyWith({
    Post? post,
    UniqueId? id,
    EventPost? relatedEvent,
  }) {
    return NoveltyPost(
      post: post ?? this.post,
      id: id ?? this.id,
      relatedEvent: relatedEvent ?? this.relatedEvent,
    );
  }

  @override
  bool get stringify => true;
}
