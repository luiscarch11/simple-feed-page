import 'package:dartz/dartz.dart';

import 'feed_page_failure.dart';
import 'shared/post/event_post.dart';
import 'shared/unique_id/unique_id.dart';
import 'shared/user.dart';

abstract class FeedPageRepository {
  Future<Either<FeedPageFailure, List<EventPost>>> getEventPostsForUser({
    required User user,
  });
  Future<Either<FeedPageFailure, List<EventPost>>> requestMorePosts();
  Future<Either<FeedPageFailure, EventPost>> requestSinglePost(UniqueId id);
}
