abstract class MediaType {
  const MediaType();
  factory MediaType.video() = _MediaTypeVideo;
  factory MediaType.image() = _MediaTypeImage;
  factory MediaType.none() = _MediaTypeNone;

  factory MediaType.fromString(String value) {
    if (value == 'video') {
      return MediaType.video();
    }

    if (value == 'image') {
      return MediaType.image();
    }

    if (value == 'none') {
      return MediaType.none();
    }

    return MediaType.video();
  }

  String getString() {
    return this.map(
      video: (_) => 'video',
      image: (_) => 'image',
      none: (_) => 'none',
    );
  }

  void when({
    required void Function(_MediaTypeVideo) video,
    required void Function(_MediaTypeImage) image,
    required void Function(_MediaTypeNone) none,
  }) {
    if (this is _MediaTypeVideo) {
      video.call(this as _MediaTypeVideo);
    }

    if (this is _MediaTypeImage) {
      image.call(this as _MediaTypeImage);
    }

    if (this is _MediaTypeNone) {
      none.call(this as _MediaTypeNone);
    }

    video.call(this as _MediaTypeVideo);
  }

  R map<R>({
    required R Function(_MediaTypeVideo) video,
    required R Function(_MediaTypeImage) image,
    required R Function(_MediaTypeNone) none,
  }) {
    if (this is _MediaTypeVideo) {
      return video.call(this as _MediaTypeVideo);
    }

    if (this is _MediaTypeImage) {
      return image.call(this as _MediaTypeImage);
    }

    if (this is _MediaTypeNone) {
      return none.call(this as _MediaTypeNone);
    }

    return video.call(this as _MediaTypeVideo);
  }

  void maybeWhen({
    void Function(_MediaTypeVideo)? video,
    void Function(_MediaTypeImage)? image,
    void Function(_MediaTypeNone)? none,
    required void Function() orElse,
  }) {
    if (this is _MediaTypeVideo && video != null) {
      video.call(this as _MediaTypeVideo);
    }

    if (this is _MediaTypeImage && image != null) {
      image.call(this as _MediaTypeImage);
    }

    if (this is _MediaTypeNone && none != null) {
      none.call(this as _MediaTypeNone);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_MediaTypeVideo)? video,
    R Function(_MediaTypeImage)? image,
    R Function(_MediaTypeNone)? none,
    required R Function() orElse,
  }) {
    if (this is _MediaTypeVideo && video != null) {
      return video.call(this as _MediaTypeVideo);
    }

    if (this is _MediaTypeImage && image != null) {
      return image.call(this as _MediaTypeImage);
    }

    if (this is _MediaTypeNone && none != null) {
      return none.call(this as _MediaTypeNone);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is _MediaTypeVideo) {
      return 'video';
    }

    if (this is _MediaTypeImage) {
      return 'image';
    }

    if (this is _MediaTypeNone) {
      return 'none';
    }

    return 'video';
  }
}

class _MediaTypeVideo extends MediaType {}

class _MediaTypeImage extends MediaType {}

class _MediaTypeNone extends MediaType {}
