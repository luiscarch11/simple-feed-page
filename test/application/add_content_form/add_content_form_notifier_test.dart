import 'package:dartz/dartz.dart';
import 'package:events_feed/application/add_content_form/add_content_form_notifier.dart';
import 'package:events_feed/domain/add_content_form_repository.dart';
import 'package:events_feed/domain/shared/age/positive_number.dart';
import 'package:events_feed/domain/shared/lat_len/lat_len.dart';
import 'package:events_feed/domain/shared/location.dart';
import 'package:events_feed/domain/shared/post/event_post.dart';
import 'package:events_feed/domain/shared/post/post.dart';
import 'package:events_feed/domain/shared/post/title/title.dart';
import 'package:events_feed/domain/shared/unique_id/unique_id.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:events_feed/domain/providers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:events_feed/domain/shared/post/description/description.dart'
    as domain;
import 'package:mockito/mockito.dart';
import '../../domain/test_utils.dart';
import 'add_content_form_notifier_test.mocks.dart';

@GenerateMocks([AddContentFormRepository])
void main() {
  late MockAddContentFormRepository mockAddContentFormRepository;
  late AddContentFormNotifier notifier;
  late AddContentFormState initialState;
  late ProviderContainer container;
  setUp(
    () {
      mockAddContentFormRepository = MockAddContentFormRepository();
      container = ProviderContainer(
        overrides: [
          insertionFormNotifierProvider.overrideWithProvider(
            StateNotifierProvider(
              (ref) => AddContentFormNotifier(mockAddContentFormRepository),
            ),
          ),
        ],
      );
      notifier = container.read(insertionFormNotifierProvider.notifier);
      initialState = AddContentFormState.initial();
      addTearDown(
        () {
          notifier.dispose();
        },
      );
    },
  );
  group(
    'Emits of new values given another value.',
    () {
      test('Given a new title value, should emit it', () {
        late AddContentFormState newState;
        notifier.addListener((state) {
          newState = state;
        });

        final newTitleValue = 'New title value';

        notifier.changeTitle(newTitleValue);

        expect(
          newState,
          initialState.copyWith(
            title: Title(newTitleValue),
          ),
        );
      });
      test('Given a new description value, should emit it', () {
        late AddContentFormState newState;
        notifier.addListener((state) {
          newState = state;
        });

        final newDescriptionValue = 'New description value';

        notifier.changeDescription(newDescriptionValue);

        expect(
          newState,
          initialState.copyWith(
            description: domain.Description(newDescriptionValue),
          ),
        );
      });
      test('Given a new event date, should emit it', () {
        late AddContentFormState newState;
        notifier.addListener((state) {
          newState = state;
        });

        final newDate = DateTime(2021, 04, 04);

        notifier.changeEventDate(newDate);

        expect(
          newState,
          initialState.copyWith(
            eventDate: newDate,
          ),
        );
      });
      test('Given a new location, should emit it', () {
        late AddContentFormState newState;
        notifier.addListener((state) {
          newState = state;
        });

        final newLocation = TestUtils.anyLocation.toLatLng();

        notifier.changeLocation(newLocation);

        expect(
          newState,
          initialState.copyWith(
            location: newLocation,
          ),
        );
      });
      test(
          'When changed calendar visibility status, it should change from true to false and vice-versa',
          () {
        late AddContentFormState newState;
        notifier.addListener((state) {
          newState = state;
        });

        notifier.changeCalendarShowStatus();

        expect(
          newState,
          initialState.copyWith(
            calendarIsExpanded: !initialState.calendarIsExpanded,
          ),
        );
      });
      test(
          'When started with a default value, all event post related fields should emit the new values from it',
          () {
        late AddContentFormState newState;
        notifier.addListener((state) {
          newState = state;
        });
        final newTitle = Title('new title');
        final newDescription = domain.Description('new description for event');
        final newDate = DateTime(2021 - 5 - 14);
        final newMaximumPeople = PositiveNumber('5');
        final newLocation = DomainLocation(
          latitude: LatLen('-32'),
          longitude: LatLen('-32'),
        );
        final newId = UniqueId();
        final newEvent = EventPost(
          maximumPeople: newMaximumPeople,
          post: Post(
            publisher: TestUtils.anyUser,
            createdAt: DateTime.now(),
            description: newDescription,
            id: newId,
            title: newTitle,
          ),
          location: newLocation,
          date: newDate,
          assistants: [],
        );
        notifier.initWithDefaultValue(newEvent);

        expect(
          newState,
          initialState.copyWith(
            title: newTitle,
            description: newDescription,
            eventDate: newDate,
            location: newLocation.toLatLng(),
            id: newId,
            maximumPeople: newMaximumPeople,
          ),
        );
      });
    },
  );

  group(
    'Repository interactions',
    () {
      group(
        'Should emit showError=true when any of [title, description, location] are null or invalid.',
        () {
          test(
            'Should emit showError=true if title is not valid',
            () {
              late AddContentFormState newState;

              notifier.addListener((state) {
                newState = state;
              });
              notifier.changeDescription('This is a valid description');
              notifier.changeLocation(TestUtils.anyLocation.toLatLng());
              notifier.changeTitle('');

              initialState = newState;
              notifier.submit(TestUtils.anyUser);
              expect(
                newState,
                initialState.copyWith(
                  showError: true,
                ),
              );
            },
          );
          test(
            'Should emit showError=true if description is not valid',
            () {
              late AddContentFormState newState;

              notifier.addListener((state) {
                newState = state;
              });
              notifier.changeDescription('');
              notifier.changeLocation(TestUtils.anyLocation.toLatLng());
              notifier.changeTitle('This is a validTitle');

              initialState = newState;
              notifier.submit(TestUtils.anyUser);
              expect(
                newState,
                initialState.copyWith(
                  showError: true,
                ),
              );
            },
          );
          test(
            'Should emit showError=true if location is null',
            () {
              late AddContentFormState newState;

              notifier.addListener((state) {
                newState = state;
              });
              notifier.changeDescription('this is a valid description');
              notifier.changeLocation(null);
              notifier.changeTitle('This is a validTitle');

              initialState = newState;
              notifier.submit(TestUtils.anyUser);
              expect(
                newState,
                initialState.copyWith(
                  showError: true,
                ),
              );
            },
          );
        },
      );
      group('Repository interactions when all data is correct', () {
        setUp(
          () {
            notifier
              ..changeDescription('This is a valid description')
              ..changeLocation(TestUtils.anyLocation.toLatLng())
              ..changeTitle('This is a valid title')
              ..changeMaximumPeople('10');
          },
        );
        test(
            'Should call insertNewContent once, and never call editContent when id is null',
            () {
          when(
            mockAddContentFormRepository.insertNewContent(
              eventDate: anyNamed('eventDate'),
              currentUser: anyNamed('currentUser'),
              description: anyNamed('description'),
              location: anyNamed('location'),
              title: anyNamed('title'),
              maximumPeople: anyNamed('maximumPeople'),
            ),
          ).thenAnswer((realInvocation) async => right(UniqueId()));
          notifier.submit(TestUtils.anyUser);
          verify(
            mockAddContentFormRepository.insertNewContent(
              eventDate: anyNamed('eventDate'),
              currentUser: anyNamed('currentUser'),
              description: anyNamed('description'),
              location: anyNamed('location'),
              title: anyNamed('title'),
              maximumPeople: anyNamed('maximumPeople'),
            ),
          ).called(1);
          verifyNever(mockAddContentFormRepository.editContent(
              eventDate: anyNamed('eventDate'),
              id: anyNamed('id'),
              description: anyNamed('description'),
              location: anyNamed('location'),
              title: anyNamed('title')));

          verifyNoMoreInteractions(mockAddContentFormRepository);
        });
        test(
            'Should call editContent once, and never call insertNewContent when id is not null',
            () {
          notifier.changeId('newIdValue');
          when(
            mockAddContentFormRepository.editContent(
              eventDate: anyNamed('eventDate'),
              id: anyNamed('id'),
              description: anyNamed('description'),
              location: anyNamed('location'),
              title: anyNamed('title'),
              maximumPeople: anyNamed('maximumPeople'),
            ),
          ).thenAnswer((realInvocation) async => right(unit));
          notifier.submit(TestUtils.anyUser);
          verifyNever(
            mockAddContentFormRepository.insertNewContent(
              eventDate: anyNamed('eventDate'),
              currentUser: anyNamed('currentUser'),
              description: anyNamed('description'),
              location: anyNamed('location'),
              title: anyNamed('title'),
              maximumPeople: anyNamed('maximumPeople'),
            ),
          );
          verify(
            mockAddContentFormRepository.editContent(
              eventDate: anyNamed('eventDate'),
              id: anyNamed('id'),
              description: anyNamed('description'),
              location: anyNamed('location'),
              title: anyNamed('title'),
              maximumPeople: anyNamed('maximumPeople'),
            ),
          ).called(1);

          verifyNoMoreInteractions(mockAddContentFormRepository);
        });

        test(
            'When any call to repository is made, should emit loading true, then loading false with the failure or unit returned by the repository, and then back to the initial state',
            () async {
          final idToReturn = UniqueId();
          when(
            mockAddContentFormRepository.insertNewContent(
              eventDate: anyNamed('eventDate'),
              currentUser: anyNamed('currentUser'),
              description: anyNamed('description'),
              location: anyNamed('location'),
              title: anyNamed('title'),
              maximumPeople: anyNamed('maximumPeople'),
            ),
          ).thenAnswer((realInvocation) async => right(idToReturn));
          final initialState = container.read(insertionFormNotifierProvider);
          final expected = [
            initialState,
            initialState.copyWith(loading: true),
            initialState.copyWith(
              loading: false,
              addContentFailureOrIdOption: some(
                right(idToReturn),
              ),
            ),
          ];
          final states = <AddContentFormState>[];
          container
              .read(insertionFormNotifierProvider.notifier)
              .addListener((state) {
            states.add(state);
          });
          await container
              .read(insertionFormNotifierProvider.notifier)
              .submit(TestUtils.anyUser);
          expect(states, expected);
        });
      });
    },
  );
}
