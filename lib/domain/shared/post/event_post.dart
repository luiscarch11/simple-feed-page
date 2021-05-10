import 'package:equatable/equatable.dart';

import '../age/positive_number.dart';
import '../location.dart';
import '../user.dart';
import 'post.dart';

class EventPost extends Equatable {
  const EventPost({
    required this.post,
    required this.location,
    required this.date,
    required this.assistants,
    required this.maximumPeople,
  });
  final Post post;
  final DomainLocation location;
  final DateTime date;
  final PositiveNumber maximumPeople;
  final List<User> assistants;

  @override
  List<Object> get props {
    return [
      post,
      location,
      date,
      assistants,
      maximumPeople,
    ];
  }

  @override
  bool get stringify => true;

  EventPost copyWith({
    Post? post,
    DomainLocation? location,
    DateTime? date,
    PositiveNumber? maximumPeople,
    List<User>? assistants,
  }) {
    return EventPost(
      maximumPeople: maximumPeople ?? this.maximumPeople,
      post: post ?? this.post,
      location: location ?? this.location,
      date: date ?? this.date,
      assistants: assistants ?? this.assistants,
    );
  }
}
