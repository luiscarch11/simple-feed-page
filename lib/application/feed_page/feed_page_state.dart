part of 'feed_page_notifier.dart';

class FeedPageState extends Equatable {
  const FeedPageState({
    required this.loadingFeed,
    required this.failureOption,
    required this.eventPostsToShow,
    required this.pendingEventPostsToShow,
    required this.pendingNoveltyPostsToShow,
    required this.noveltyPostsToShow,
    required this.loadingMoreEvents,
  });
  factory FeedPageState.initial() => FeedPageState(
        failureOption: none(),
        loadingFeed: false,
        loadingMoreEvents: false,
        eventPostsToShow: [],
        noveltyPostsToShow: [],
        pendingEventPostsToShow: [],
        pendingNoveltyPostsToShow: [],
      );
  final bool loadingFeed;
  final bool loadingMoreEvents;
  final Option<FeedPageFailure> failureOption;
  final List<EventPost> eventPostsToShow;
  final List<EventPost> pendingEventPostsToShow;
  final List<NoveltyPost> noveltyPostsToShow;
  final List<NoveltyPost> pendingNoveltyPostsToShow;

  @override
  List<Object> get props => [
        loadingFeed,
        failureOption,
        loadingMoreEvents,
        eventPostsToShow,
        pendingEventPostsToShow,
        pendingNoveltyPostsToShow,
        noveltyPostsToShow
      ];

  FeedPageState copyWith({
    bool? loading,
    bool? loadingMoreEvents,
    Option<FeedPageFailure>? failureOption,
    List<EventPost>? eventPostsToShow,
    List<NoveltyPost>? noveltyPostsToShow,
    List<NoveltyPost>? pendingNoveltyPostsToShow,
    List<EventPost>? pendingEventPostsToShow,
  }) {
    return FeedPageState(
      loadingMoreEvents: loadingMoreEvents ?? this.loadingMoreEvents,
      pendingNoveltyPostsToShow:
          pendingNoveltyPostsToShow ?? this.pendingNoveltyPostsToShow,
      pendingEventPostsToShow:
          pendingEventPostsToShow ?? this.pendingEventPostsToShow,
      loadingFeed: loading ?? this.loadingFeed,
      failureOption: failureOption ?? this.failureOption,
      eventPostsToShow: eventPostsToShow ?? this.eventPostsToShow,
      noveltyPostsToShow: noveltyPostsToShow ?? this.noveltyPostsToShow,
    );
  }
}
