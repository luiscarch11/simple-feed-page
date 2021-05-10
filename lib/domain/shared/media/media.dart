import 'package:equatable/equatable.dart';

import 'media_type/media_type.dart';
import 'url/url.dart';

class Media extends Equatable {
  const Media({
    required this.type,
    required this.url,
  });
  final MediaType type;
  final Url url;

  @override
  List<Object> get props => [type, url];

  Media copyWith({
    MediaType? type,
    Url? url,
  }) {
    return Media(
      type: type ?? this.type,
      url: url ?? this.url,
    );
  }

  @override
  bool get stringify => true;
}
