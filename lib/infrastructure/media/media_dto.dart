import '../../domain/shared/media/media.dart';
import '../../domain/shared/media/media_type/media_type.dart';
import '../../domain/shared/media/url/url.dart';

class MediaDto {
  const MediaDto._({
    required this.url,
    required this.type,
  });
  final String url;
  final String type;

  static MediaDto fromJson(Map<String, dynamic> json) {
    return MediaDto._(
      url: json['url'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'type': type,
    };
  }

  static MediaDto fromDomain(Media domain) {
    return MediaDto._(
      url: domain.url.getOrCrash(),
      type: domain.type.getString(),
    );
  }

  Media toDomain() {
    return Media(
      url: Url(this.url),
      type: MediaType.fromString(this.type),
    );
  }
}
