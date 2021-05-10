import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/add_content_form_failure.dart';
import '../../domain/add_content_form_repository.dart';
import '../../domain/shared/age/positive_number.dart';
import '../../domain/shared/post/description/description.dart';
import '../../domain/shared/post/event_post.dart';
import '../../domain/shared/post/title/title.dart';
import '../../domain/shared/unique_id/unique_id.dart';
import '../../domain/shared/user.dart';

part 'add_content_form_state.dart';

class AddContentFormNotifier extends StateNotifier<AddContentFormState> {
  AddContentFormNotifier(this._addContentFormRepository)
      : super(AddContentFormState.initial());
  final AddContentFormRepository _addContentFormRepository;

  bool get _isEditting => state.id != null;
  void initialize() {
    state = AddContentFormState.initial();
  }

  void initWithDefaultValue(EventPost defaultValue) {
    state = state.copyWith(
      description: defaultValue.post.description,
      title: defaultValue.post.title,
      id: defaultValue.post.id,
      eventDate: defaultValue.date,
      location: defaultValue.location.toLatLng(),
      maximumPeople: defaultValue.maximumPeople,
    );
  }

  void initWithoutDefault() {
    state = AddContentFormState.initial();
  }

  void changeMaximumPeople(String newMax) {
    clearFailureOrSuccess();
    state = state.copyWith(
      maximumPeople: PositiveNumber(newMax),
    );
  }

  void changeCalendarShowStatus() {
    clearFailureOrSuccess();
    state = state.copyWith(
      calendarIsExpanded: !state.calendarIsExpanded,
    );
  }

  void changeId(String newId) {
    clearFailureOrSuccess();
    state = state.copyWith(
      id: UniqueId.fromString(newId),
    );
  }

  void clearFailureOrSuccess() {
    state = state.copyWith(
      addContentFailureOrIdOption: none(),
      editContentFailureOrSuccessOption: none(),
    );
  }

  void changeTitle(String newTitle) {
    clearFailureOrSuccess();
    state = state.copyWith(
      title: Title(newTitle),
    );
  }

  void changeDescription(String newDescription) {
    clearFailureOrSuccess();
    state = state.copyWith(
      description: Description(newDescription),
    );
  }

  void changeEventDate(DateTime newEventData) {
    clearFailureOrSuccess();
    state = state.copyWith(
      eventDate: newEventData,
    );
  }

  void changeLocation(LatLng? newLocation) {
    clearFailureOrSuccess();
    state = state.copyWith(
      location: newLocation ?? state.location,
    );
  }

  Future<void> submit(User currentUser) async {
    if (!_isValid()) {
      state = state.copyWith(
        showError: true,
      );
      return;
    }
    state = state.copyWith(loading: true);
    if (_isEditting) {
      final result = await _addContentFormRepository.editContent(
        id: state.id!,
        description: state.description,
        eventDate: state.eventDate,
        location: state.location!,
        title: state.title,
        maximumPeople: state.maximumPeople,
      );
      state = state.copyWith(
        loading: false,
        editContentFailureOrSuccessOption: some(result),
      );

      return;
    }
    final result = await _addContentFormRepository.insertNewContent(
      description: state.description,
      eventDate: state.eventDate,
      location: state.location!,
      title: state.title,
      currentUser: currentUser,
      maximumPeople: state.maximumPeople,
    );
    state = state.copyWith(
      loading: false,
      addContentFailureOrIdOption: some(result),
    );
  }

  bool _isValid() {
    return state.title.isValid &&
        state.description.isValid &&
        state.location != null &&
        state.maximumPeople.isValid;
  }
}
