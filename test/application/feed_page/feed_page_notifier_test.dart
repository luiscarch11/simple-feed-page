import 'package:dartz/dartz.dart';
import 'package:events_feed/application/feed_page/feed_page_notifier.dart';
import 'package:events_feed/domain/feed_page_failure.dart';
import 'package:events_feed/domain/feed_page_repository.dart';
import 'package:events_feed/domain/providers.dart';
import 'package:events_feed/domain/shared/post/event_post.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../domain/test_utils.dart';
import 'feed_page_notifier_test.mocks.dart';

@GenerateMocks([FeedPageRepository])
void main() {
  late FeedPageNotifier notifier;
  late FeedPageState initialState;
  late MockFeedPageRepository repository;
  setUp(
    () {
      initialState = FeedPageState.initial();
      repository = MockFeedPageRepository();
      final container = ProviderContainer(
        overrides: [
          feedPageNotifierProvider.overrideWithProvider(
            StateNotifierProvider(
              (ref) => FeedPageNotifier(repository),
            ),
          ),
        ],
      );
      notifier = container.read(feedPageNotifierProvider.notifier);
      addTearDown(
        () {
          container.dispose();
        },
      );
    },
  );
  group('When called init.', () {
    List<EventPost> postsToReturn = [];
    setUp(
      () {
        when(
          repository.getEventPostsForUser(
            user: anyNamed('user'),
          ),
        ).thenAnswer(
          (realInvocation) async => right(postsToReturn),
        );
      },
    );
    test('Should call once getEvents from repository.', () async {
      notifier.init(TestUtils.anyUser);
      verify(
        repository.getEventPostsForUser(user: anyNamed('user')),
      ).called(1);
      verifyNoMoreInteractions(repository);
    });
    test(
      'Should emit loading:true, then loading: false and the list of events returned by the repository. ',
      () async {
        final expected = [
          initialState,
          initialState.copyWith(
            loading: true,
          ),
          initialState.copyWith(
            loading: false,
            eventPostsToShow: postsToReturn,
          ),
        ];
        final states = [];
        notifier.addListener(
          (state) {
            states.add(state);
          },
        );
        await notifier.init(TestUtils.anyUser);

        expect(
          states,
          expected,
        );
      },
    );
    test(
      'Should emit loading:true, then loading: false and the failure returned by the repository. ',
      () async {
        final failureToReturn = FeedPageFailure.serverError();
        when(
          repository.getEventPostsForUser(
            user: anyNamed('user'),
          ),
        ).thenAnswer(
          (realInvocation) async => left(failureToReturn),
        );
        final expected = [
          initialState,
          initialState.copyWith(
            loading: true,
          ),
          initialState.copyWith(
            loading: false,
            failureOption: some(failureToReturn),
          ),
        ];
        final states = [];
        notifier.addListener(
          (state) {
            states.add(state);
          },
        );
        await notifier.init(TestUtils.anyUser);

        expect(
          states,
          expected,
        );
      },
    );
  });
  group('When called requestMoreEvents.', () {
    final List<EventPost> postsToReturn = [];
    setUp(
      () {
        when(repository.requestMorePosts()).thenAnswer(
          (realInvocation) async => right(postsToReturn),
        );
      },
    );
    test('repository requestMorePosts should be called once.', () {
      notifier.requestMoreEvents();
      verify(repository.requestMorePosts()).called(1);
      verifyNoMoreInteractions(repository);
    });
    test(
        'When repository returns right, should emit [loadingMoreEvents=true, loadingMoreEvents=false and add new events returned to the current state]',
        () async {
      final expected = [
        initialState,
        initialState.copyWith(
          loadingMoreEvents: true,
        ),
        initialState.copyWith(
            loadingMoreEvents: false,
            eventPostsToShow: initialState.eventPostsToShow
              ..addAll(postsToReturn)),
      ];
      final states = <FeedPageState>[];
      notifier.addListener(
        (state) {
          states.add(state);
        },
      );
      await notifier.requestMoreEvents();
      expect(
        states,
        expected,
      );
    });
    test(
        'When repository returns left, should emit [loadingMoreEvents=true, loadingMoreEvents=false and failure=some(failurereturned)]',
        () async {
      final failureToReturn = FeedPageFailure.serverError();
      final expected = [
        initialState,
        initialState.copyWith(
          loadingMoreEvents: true,
        ),
        initialState.copyWith(
          loadingMoreEvents: false,
          failureOption: some(failureToReturn),
        ),
      ];
      when(repository.requestMorePosts()).thenAnswer(
        (realInvocation) async => left(failureToReturn),
      );
      final states = <FeedPageState>[];
      notifier.addListener(
        (state) {
          states.add(state);
        },
      );
      await notifier.requestMoreEvents();

      expect(
        states,
        expected,
      );
    });
  });
}
