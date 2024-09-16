import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class Hive extends Equatable {
  final String id;
  final String? apiaryId;
  final String type; //Langstroth, Top Bar, Warre
  final String name;
  final int order; //order in apiary
  final DateTime createdAt;

  Hive({
    String? id,
    this.apiaryId,
    required this.type,
    required this.name,
    required this.order,
    required DateTime createdAt,
  })  : id = id ?? Uuid().v4(),
        createdAt = createdAt.copyWith(millisecond: 0, microsecond: 0);

  Hive copyWith({
    String? apiaryId,
    DateTime? createdAt,
    String? type,
    String? name,
    int? order,
  }) {
    return Hive(
      id: this.id,
      apiaryId: apiaryId ?? this.apiaryId,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      name: name ?? this.name,
      order: order ?? this.order,
    );
  }

  @override
  List<Object?> get props => [id, createdAt, type, name, order];
}
