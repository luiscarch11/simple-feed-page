part of 'add_content_form_notifier.dart';

class AddContentFormState extends Equatable {
  const AddContentFormState({
    required this.calendarIsExpanded,
    required this.showError,
    required this.loading,
    required this.eventDate,
    required this.title,
    required this.description,
    required this.id,
    required this.location,
    required this.maximumPeople,
    required this.addContentFailureOrIdOption,
    required this.editContentFailureOrSuccessOption,
  });
  factory AddContentFormState.initial() => AddContentFormState(
        calendarIsExpanded: false,
        id: null,
        eventDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        loading: false,
        location: null,
        description: Description(''),
        title: Title(''),
        addContentFailureOrIdOption: none(),
        editContentFailureOrSuccessOption: none(),
        maximumPeople: PositiveNumber(''),
        showError: false,
      );
  final bool calendarIsExpanded;
  final bool showError;
  final bool loading;
  final UniqueId? id;
  final DateTime eventDate;
  final Option<Either<AddContentFormFailure, UniqueId>>
      addContentFailureOrIdOption;
  final Option<Either<AddContentFormFailure, Unit>>
      editContentFailureOrSuccessOption;
  final Title title;
  final Description description;
  final LatLng? location;
  final PositiveNumber maximumPeople;
  @override
  List<Object?> get props {
    return [
      calendarIsExpanded,
      showError,
      loading,
      eventDate,
      title,
      description,
      location,
      maximumPeople,
      addContentFailureOrIdOption,
      id,
      editContentFailureOrSuccessOption,
    ];
  }

  AddContentFormState copyWith({
    bool? calendarIsExpanded,
    bool? showError,
    bool? loading,
    DateTime? eventDate,
    Title? title,
    Description? description,
    LatLng? location,
    PositiveNumber? maximumPeople,
    UniqueId? id,
    Option<Either<AddContentFormFailure, UniqueId>>?
        addContentFailureOrIdOption,
    Option<Either<AddContentFormFailure, Unit>>?
        editContentFailureOrSuccessOption,
  }) {
    return AddContentFormState(
      id: id ?? this.id,
      addContentFailureOrIdOption:
          addContentFailureOrIdOption ?? this.addContentFailureOrIdOption,
      editContentFailureOrSuccessOption: editContentFailureOrSuccessOption ??
          this.editContentFailureOrSuccessOption,
      calendarIsExpanded: calendarIsExpanded ?? this.calendarIsExpanded,
      showError: showError ?? this.showError,
      loading: loading ?? this.loading,
      eventDate: eventDate ?? this.eventDate,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      maximumPeople: maximumPeople ?? this.maximumPeople,
    );
  }
}
