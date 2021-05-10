import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../domain/feed_page_failure.dart';
import '../domain/feed_page_repository.dart';
import '../domain/shared/post/event_post.dart';
import '../domain/shared/unique_id/unique_id.dart';
import '../domain/shared/user.dart';
import 'post/event_post_dto.dart';

class FirestoreFeedPageRepository implements FeedPageRepository {
  late DocumentSnapshot _lastElement;
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;
  @override
  Future<Either<FeedPageFailure, List<EventPost>>> getEventPostsForUser({
    required User user,
  }) async {
    try {
      return _firestore
          .collection('events')
          .limit(_elementsPerRequestLimit)
          .get()
          .then(
        (value) {
          final documents = value.docs;
          if (documents.isNotEmpty) _lastElement = documents.last;
          return right(
            documents.map((e) {
              final eventToReturn = EventPostDto.fromJson(e.data()).toDomain();
              return eventToReturn;
            }).toList(),
          );
        },
      );
    } on FirebaseException catch (_) {
      return left(FeedPageFailure.serverError());
    }
  }

  @override
  Future<Either<FeedPageFailure, List<EventPost>>> requestMorePosts() async {
    try {
      return _firestore
          .collection('events')
          .startAfterDocument(_lastElement)
          .limit(_elementsPerRequestLimit)
          .get()
          .then(
        (value) {
          final documents = value.docs;
          if (documents.isNotEmpty) _lastElement = documents.last;
          return right(
            documents.map((e) {
              final eventToReturn = EventPostDto.fromJson(e.data()).toDomain();
              return eventToReturn;
            }).toList(),
          );
        },
      );
    } on FirebaseException catch (_) {
      return left(FeedPageFailure.serverError());
    }
  }

  int get _elementsPerRequestLimit => 5;

  @override
  Future<Either<FeedPageFailure, EventPost>> requestSinglePost(
      UniqueId id) async {
    final document = await _firestore
        .collection('events')
        .doc(id.getOrCrash())
        .get()
        .then((value) => value);
    if (document.data() != null) {
      return right(EventPostDto.fromJson(document.data()!).toDomain());
    }
    return left(FeedPageFailure.documentUnreachable());
  }
}
