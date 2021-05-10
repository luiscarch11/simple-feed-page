import 'package:dartz/dartz.dart';
import 'package:events_feed/application/map_selector/map_selector_notifier.dart';
import 'package:events_feed/domain/map_selector_failure.dart';
import 'package:events_feed/domain/map_selector_repository.dart';
import 'package:events_feed/domain/providers.dart';
import 'package:events_feed/domain/shared/lat_len/lat_len.dart';
import 'package:events_feed/domain/shared/location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'map_selector_test.mocks.dart';

@GenerateMocks([MapSelectorRepository])
void main() {
  late MockMapSelectorRepository mockMapSelectorRepository;
  late MapSelectorNotifier notifier;
  late MapSelectorState initialState;
  setUp(
    () {
      mockMapSelectorRepository = MockMapSelectorRepository();
      final container = ProviderContainer(
        overrides: [
          mapSelectorNotifierProvider.overrideWithProvider(
            StateNotifierProvider(
              (ref) => MapSelectorNotifier(mockMapSelectorRepository),
            ),
          ),
        ],
      );
      notifier = container.read(mapSelectorNotifierProvider.notifier);
      initialState = MapSelectorState.initial();
    },
  );
  test(
    'When initialized, should call getUserLocation once ',
    () {
      when(mockMapSelectorRepository.getUserLocation()).thenAnswer(
        (realInvocation) async => right(
          DomainLocation(
            latitude: LatLen('-30'),
            longitude: LatLen('-30'),
          ),
        ),
      );
      notifier.init();
      verify(mockMapSelectorRepository.getUserLocation()).called(1);
      verifyNoMoreInteractions(mockMapSelectorRepository);
    },
  );
  test(
    'When changed markLocation, should update markLocation to the given one',
    () {
      final _newMarkLocation = LatLng(-40, -40);
      late MapSelectorState newState;
      notifier.addListener((state) {
        newState = state;
      });
      notifier.changeMarkLocation(_newMarkLocation);

      expect(
        newState,
        initialState.copyWith(
          markLocation: _newMarkLocation,
        ),
      );
    },
  );
  group('When initialized and repository response is either left or right.',
      () {
    test(
      'When response is right Should emit [loading=true, {loading=false, userLocation:LatLng with latitude and longitude returned by repository}]',
      () async {
        final _latitudeToReturn = -30.0;
        final _longitudeToReturn = -30.0;
        when(mockMapSelectorRepository.getUserLocation()).thenAnswer(
          (realInvocation) async => right(
            DomainLocation(
              latitude: LatLen('-30'),
              longitude: LatLen('-30'),
            ),
          ),
        );
        final expected = [
          initialState,
          initialState.copyWith(loading: true),
          initialState.copyWith(
            userLocation: LatLng(
              _latitudeToReturn,
              _longitudeToReturn,
            ),
          )
        ];

        final states = <MapSelectorState>[];

        notifier.addListener(
          (state) {
            states.add(state);
          },
        );
        await notifier.init();
        expect(expected, states);
      },
    );
    test(
      'When response is left Should emit [loading=true, {loading=false, userLocationFailure:failureReturnedByRepository}]',
      () async {
        final failureToReturn = MapSelectorFailure.couldntGetLocation();
        when(mockMapSelectorRepository.getUserLocation()).thenAnswer(
          (realInvocation) async => left(failureToReturn),
        );
        final expected = [
          initialState,
          initialState.copyWith(loading: true),
          initialState.copyWith(
            userLocationFailure: right(failureToReturn),
          )
        ];

        final states = <MapSelectorState>[];

        notifier.addListener(
          (state) {
            states.add(state);
          },
        );
        await notifier.init();
        expect(expected, states);
      },
    );
  });
}
