import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class Raport extends Equatable {
  final String id;
  final String? hiveId;
  final DateTime createdAt;

  Raport({
    String? id,
    this.hiveId,
    required DateTime createdAt,
  })  : id = id ?? Uuid().v4(),
        createdAt = createdAt.copyWith(millisecond: 0, microsecond: 0);

  Raport copyWith({
    String? hiveId,
    DateTime? createdAt,
  }) {
    return Raport(
      id: this.id,
      hiveId: hiveId ?? this.hiveId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, hiveId, createdAt];
}