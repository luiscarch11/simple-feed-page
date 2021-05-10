import 'package:equatable/equatable.dart';

import 'relationship/relationship.dart';
import 'user.dart';

class Contact extends Equatable {
  const Contact({
    required this.user,
    required this.relationship,
  });
  final User user;
  final Relationship relationship;

  @override
  List<Object> get props => [user, relationship];

  @override
  bool get stringify => true;

  Contact copyWith({
    User? user,
    Relationship? relationship,
  }) {
    return Contact(
      user: user ?? this.user,
      relationship: relationship ?? this.relationship,
    );
  }
}
