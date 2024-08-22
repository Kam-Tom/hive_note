import 'package:db_api/db_api.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class Hive extends Equatable {
  final String id;
  final Queen? queen;
  final String type; //Langstroth, Top Bar, Warre
  final String name;
  final int order; //order in apiary
  final DateTime createdAt;

  Hive({
    String? id,
    this.queen,
    required this.type,
    required this.name,
    required this.order,
    required DateTime createdAt,
  })  : id = id ?? Uuid().v4(),
        createdAt = createdAt.copyWith(millisecond: 0, microsecond: 0);

  Hive copyWith({
    Queen? queen,
    DateTime? createdAt,
    String? type,
    String? name,
    int? order,
  }) {
    return Hive(
      id: this.id,
      queen: queen ?? this.queen,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      name: name ?? this.name,
      order: order ?? this.order,
    );
  }

  @override
  List<Object?> get props => [id, queen, createdAt, type, name, order];
}
