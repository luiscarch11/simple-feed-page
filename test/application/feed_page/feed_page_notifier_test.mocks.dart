// Mocks generated by Mockito 5.0.7 from annotations
// in events_feed/test/application/feed_page/feed_page_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:events_feed/domain/feed_page_failure.dart' as _i5;
import 'package:events_feed/domain/feed_page_repository.dart' as _i3;
import 'package:events_feed/domain/shared/post/event_post.dart' as _i6;
import 'package:events_feed/domain/shared/unique_id/unique_id.dart' as _i8;
import 'package:events_feed/domain/shared/user.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

class _FakeEither<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [FeedPageRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockFeedPageRepository extends _i1.Mock
    implements _i3.FeedPageRepository {
  MockFeedPageRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.FeedPageFailure, List<_i6.EventPost>>>
      getEventPostsForUser({_i7.User? user}) => (super.noSuchMethod(
          Invocation.method(#getEventPostsForUser, [], {#user: user}),
          returnValue: Future<
                  _i2.Either<_i5.FeedPageFailure, List<_i6.EventPost>>>.value(
              _FakeEither<_i5.FeedPageFailure, List<_i6.EventPost>>())) as _i4
          .Future<_i2.Either<_i5.FeedPageFailure, List<_i6.EventPost>>>);
  @override
  _i4.Future<_i2.Either<_i5.FeedPageFailure, List<_i6.EventPost>>>
      requestMorePosts() => (super.noSuchMethod(
          Invocation.method(#requestMorePosts, []),
          returnValue: Future<
                  _i2.Either<_i5.FeedPageFailure, List<_i6.EventPost>>>.value(
              _FakeEither<_i5.FeedPageFailure, List<_i6.EventPost>>())) as _i4
          .Future<_i2.Either<_i5.FeedPageFailure, List<_i6.EventPost>>>);
  @override
  _i4.Future<_i2.Either<_i5.FeedPageFailure, _i6.EventPost>> requestSinglePost(
          _i8.UniqueId? id) =>
      (super.noSuchMethod(Invocation.method(#requestSinglePost, [id]),
              returnValue:
                  Future<_i2.Either<_i5.FeedPageFailure, _i6.EventPost>>.value(
                      _FakeEither<_i5.FeedPageFailure, _i6.EventPost>()))
          as _i4.Future<_i2.Either<_i5.FeedPageFailure, _i6.EventPost>>);
}
