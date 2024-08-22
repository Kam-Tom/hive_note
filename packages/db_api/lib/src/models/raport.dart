import 'package:db_api/db_api.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class Raport extends Equatable {
  final String id;
  final Hive? hive;
  final DateTime createdAt;

  Raport({
    String? id,
    this.hive,
    required DateTime createdAt,
  })  : id = id ?? Uuid().v4(),
        createdAt = createdAt.copyWith(millisecond: 0, microsecond: 0);

  Raport copyWith({
    Hive? hive,
    DateTime? createdAt,
  }) {
    return Raport(
      id: this.id,
      hive: hive ?? this.hive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, hive, createdAt];
}