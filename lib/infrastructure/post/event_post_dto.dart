import '../../domain/shared/age/positive_number.dart';
import '../../domain/shared/post/event_post.dart';
import '../location_dto.dart';
import '../user_dto.dart';
import 'post_dto.dart';

class EventPostDto {
  const EventPostDto._({
    required this.event,
    required this.location,
    required this.date,
    required this.assistants,
    required this.maximumPeople,
  });
  final PostDto event;
  final LocationDto location;
  final int maximumPeople;
  final int date;
  final List<UserDto> assistants;

  static EventPostDto fromJson(Map<String, dynamic> json) {
    return EventPostDto._(
      maximumPeople: json['maximumPeople'],
      event: PostDto.fromJson(json),
      location: LocationDto.fromJson(json['location']),
      date: json['date'],
      assistants: (json['assistants'] as List)
          .map(
            (e) => UserDto.fromJson(e),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maximumPeople': maximumPeople,
      'event': event,
      'location': location,
      'date': date,
      'assistants': assistants,
    };
  }

  static EventPostDto fromDomain(EventPost domain) {
    return EventPostDto._(
      maximumPeople: domain.maximumPeople.getOrCrash(),
      event: PostDto.fromDomain(domain.post),
      location: LocationDto.fromDomain(domain.location),
      date: domain.date.millisecondsSinceEpoch,
      assistants: domain.assistants
          .map(
            (e) => UserDto.fromDomain(e),
          )
          .toList(),
    );
  }

  EventPost toDomain() {
    return EventPost(
      maximumPeople: PositiveNumber(maximumPeople.toString()),
      post: this.event.toDomain(),
      location: this.location.toDomain(),
      date: DateTime.fromMillisecondsSinceEpoch(this.date),
      assistants: this
          .assistants
          .map(
            (e) => e.toDomain(),
          )
          .toList(),
    );
  }
}
