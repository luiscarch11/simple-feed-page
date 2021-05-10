import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/feed_page_failure.dart';
import '../../domain/feed_page_repository.dart';
import '../../domain/shared/post/event_post.dart';
import '../../domain/shared/post/novelty_post.dart';
import '../../domain/shared/unique_id/unique_id.dart';
import '../../domain/shared/user.dart';

part 'feed_page_state.dart';

class FeedPageNotifier extends StateNotifier<FeedPageState> {
  FeedPageNotifier(this._feedPageRepository) : super(FeedPageState.initial());
  final FeedPageRepository _feedPageRepository;

  Future<void> init(User currentUser) async {
    state = state.copyWith(
      loading: true,
    );
    final eventsOrFailure =
        await _feedPageRepository.getEventPostsForUser(user: currentUser);

    eventsOrFailure.fold(
      (l) => state = state.copyWith(
        failureOption: some(l),
        loading: false,
      ),
      (r) => state = state.copyWith(
        loading: false,
        eventPostsToShow: _getNewEventsToShow(r),
      ),
    );
  }

  Future<void> requestMoreEvents() async {
    state = state.copyWith(
      loadingMoreEvents: true,
    );
    final newPostsOrFailure = await _feedPageRepository.requestMorePosts();

    newPostsOrFailure.fold(
      (l) => state = state.copyWith(
        failureOption: some(l),
        loadingMoreEvents: false,
      ),
      (r) => state = state.copyWith(
        loadingMoreEvents: false,
        eventPostsToShow: _getNewEventsToShow(r),
      ),
    );
  }

  Future<void> changeValueForPost(UniqueId id) async {
    final posts = List<EventPost>.from(state.eventPostsToShow);
    final editedPostIndex = posts.indexWhere(
      (element) => element.post.id == id,
    );
    final newPostOrFailure = await _requestNewPost(id);
    newPostOrFailure.fold(
      (l) => state = state.copyWith(
        loading: false,
        failureOption: some(l),
      ),
      (r) {
        posts[editedPostIndex] = r;
        state = state.copyWith(
          loading: false,
          failureOption: none(),
          eventPostsToShow: posts,
        );
      },
    );
    state = state.copyWith(
      eventPostsToShow: posts,
    );
  }

  Future<Either<FeedPageFailure, EventPost>> _requestNewPost(
      UniqueId id) async {
    state = state.copyWith(
      loading: true,
    );
    final newPostOrFailure = await _feedPageRepository.requestSinglePost(id);
    return newPostOrFailure;
  }

  Future<void> addNewPostToFeed(UniqueId id) async {
    final newPostOrFailure = await _requestNewPost(id);
    newPostOrFailure.fold(
      (l) => state = state.copyWith(
        failureOption: some(l),
        loading: false,
      ),
      (r) {
        final currentEvents = List<EventPost>.from(state.eventPostsToShow);
        currentEvents.insert(0, r);
        state = state.copyWith(
          loading: false,
          failureOption: none(),
          eventPostsToShow: currentEvents,
        );
      },
    );
  }

  List<EventPost> _getNewEventsToShow(List<EventPost> events) {
    final currentEvents = List<EventPost>.from(state.eventPostsToShow);
    currentEvents.addAll(events);
    return currentEvents;
  }
}
