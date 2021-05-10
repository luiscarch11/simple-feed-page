import 'package:equatable/equatable.dart';

import '../unique_id/unique_id.dart';

import 'interest_name/interest_name.dart';

class Interest extends Equatable {
  const Interest({
    required this.id,
    required this.name,
  });
  final UniqueId id;
  final InterestName name;

  Interest copyWith({
    UniqueId? id,
    InterestName? name,
  }) {
    return Interest(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object> get props => [id, name];

  @override
  bool get stringify => true;
}
