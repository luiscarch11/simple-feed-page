import 'package:equatable/equatable.dart';

import '../unique_id/unique_id.dart';
import '../user.dart';
import 'description/description.dart';
import 'title/title.dart';

class Post extends Equatable {
  const Post({
    required this.createdAt,
    required this.id,
    required this.title,
    required this.publisher,
    required this.description,
  });
  final UniqueId id;
  final Title title;
  final DateTime createdAt;
  final User publisher;
  final Description description;

  @override
  List<Object> get props {
    return [
      id,
      title,
      publisher,
      description,
      createdAt,
    ];
  }

  Post copyWith({
    UniqueId? id,
    Title? title,
    User? publisher,
    DateTime? createdAt,
    Description? description,
  }) {
    return Post(
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      title: title ?? this.title,
      publisher: publisher ?? this.publisher,
      description: description ?? this.description,
    );
  }

  @override
  bool get stringify => true;
}
