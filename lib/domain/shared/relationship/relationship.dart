abstract class Relationship {
  const Relationship();
  factory Relationship.nearFamily() = _RelationshipNearFamily;
  factory Relationship.family() = _RelationshipFamily;
  factory Relationship.friend() = _RelationshipFriend;
  factory Relationship.known() = _RelationshipKnown;
  factory Relationship.unknown() = _RelationshipUnknown;

  factory Relationship.fromString(String value) {
    if (value == 'nearFamily') {
      return Relationship.nearFamily();
    }

    if (value == 'family') {
      return Relationship.family();
    }

    if (value == 'friend') {
      return Relationship.friend();
    }

    if (value == 'known') {
      return Relationship.known();
    }

    if (value == 'unknown') {
      return Relationship.unknown();
    }

    return Relationship.nearFamily();
  }
  String getString() {
    return this.map(
      nearFamily: (_) => 'nearFamily',
      family: (_) => 'family',
      friend: (_) => 'friend',
      known: (_) => 'known',
      unknown: (_) => 'unknown',
    );
  }

  int get closeLevel {
    return this.map(
      nearFamily: (_) => 5,
      family: (_) => 4,
      friend: (_) => 3,
      known: (_) => 2,
      unknown: (_) => 1,
    );
  }

  void when({
    required void Function(_RelationshipNearFamily) nearFamily,
    required void Function(_RelationshipFamily) family,
    required void Function(_RelationshipFriend) friend,
    required void Function(_RelationshipKnown) known,
    required void Function(_RelationshipUnknown) unknown,
  }) {
    if (this is _RelationshipNearFamily) {
      nearFamily.call(this as _RelationshipNearFamily);
    }

    if (this is _RelationshipFamily) {
      family.call(this as _RelationshipFamily);
    }

    if (this is _RelationshipFriend) {
      friend.call(this as _RelationshipFriend);
    }

    if (this is _RelationshipKnown) {
      known.call(this as _RelationshipKnown);
    }

    if (this is _RelationshipUnknown) {
      unknown.call(this as _RelationshipUnknown);
    }

    nearFamily.call(this as _RelationshipNearFamily);
  }

  R map<R>({
    required R Function(_RelationshipNearFamily) nearFamily,
    required R Function(_RelationshipFamily) family,
    required R Function(_RelationshipFriend) friend,
    required R Function(_RelationshipKnown) known,
    required R Function(_RelationshipUnknown) unknown,
  }) {
    if (this is _RelationshipNearFamily) {
      return nearFamily.call(this as _RelationshipNearFamily);
    }

    if (this is _RelationshipFamily) {
      return family.call(this as _RelationshipFamily);
    }

    if (this is _RelationshipFriend) {
      return friend.call(this as _RelationshipFriend);
    }

    if (this is _RelationshipKnown) {
      return known.call(this as _RelationshipKnown);
    }

    if (this is _RelationshipUnknown) {
      return unknown.call(this as _RelationshipUnknown);
    }

    return nearFamily.call(this as _RelationshipNearFamily);
  }

  void maybeWhen({
    void Function(_RelationshipNearFamily)? nearFamily,
    void Function(_RelationshipFamily)? family,
    void Function(_RelationshipFriend)? friend,
    void Function(_RelationshipKnown)? known,
    void Function(_RelationshipUnknown)? unknown,
    required void Function() orElse,
  }) {
    if (this is _RelationshipNearFamily && nearFamily != null) {
      nearFamily.call(this as _RelationshipNearFamily);
    }

    if (this is _RelationshipFamily && family != null) {
      family.call(this as _RelationshipFamily);
    }

    if (this is _RelationshipFriend && friend != null) {
      friend.call(this as _RelationshipFriend);
    }

    if (this is _RelationshipKnown && known != null) {
      known.call(this as _RelationshipKnown);
    }

    if (this is _RelationshipUnknown && unknown != null) {
      unknown.call(this as _RelationshipUnknown);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_RelationshipNearFamily)? nearFamily,
    R Function(_RelationshipFamily)? family,
    R Function(_RelationshipFriend)? friend,
    R Function(_RelationshipKnown)? known,
    R Function(_RelationshipUnknown)? unknown,
    required R Function() orElse,
  }) {
    if (this is _RelationshipNearFamily && nearFamily != null) {
      return nearFamily.call(this as _RelationshipNearFamily);
    }

    if (this is _RelationshipFamily && family != null) {
      return family.call(this as _RelationshipFamily);
    }

    if (this is _RelationshipFriend && friend != null) {
      return friend.call(this as _RelationshipFriend);
    }

    if (this is _RelationshipKnown && known != null) {
      return known.call(this as _RelationshipKnown);
    }

    if (this is _RelationshipUnknown && unknown != null) {
      return unknown.call(this as _RelationshipUnknown);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is _RelationshipNearFamily) {
      return 'nearFamily';
    }

    if (this is _RelationshipFamily) {
      return 'family';
    }

    if (this is _RelationshipFriend) {
      return 'friend';
    }

    if (this is _RelationshipKnown) {
      return 'known';
    }

    if (this is _RelationshipUnknown) {
      return 'unknown';
    }

    return 'nearFamily';
  }
}

class _RelationshipNearFamily extends Relationship {}

class _RelationshipFamily extends Relationship {}

class _RelationshipFriend extends Relationship {}

class _RelationshipKnown extends Relationship {}

class _RelationshipUnknown extends Relationship {}
