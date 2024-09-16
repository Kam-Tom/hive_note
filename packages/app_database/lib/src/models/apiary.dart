import 'package:app_database/app_database.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import 'dart:ui';

@immutable
class Apiary extends Equatable {
  final String id;
  final String name;
  final Color color;
  final bool isActive;
  final int order;
  final DateTime createdAt;

  Apiary({
    String? id,
    required this.name,
    required this.order,
    Color? color,
    int? colorValue,
    bool? isActive,
    required DateTime createdAt,
  })  : id = id ?? Uuid().v4(),
        color = color ?? Color(colorValue ?? 0xFF000000), // black by default
        isActive = isActive ?? false,
        createdAt = createdAt.copyWith(millisecond: 0, microsecond: 0);

  Apiary copyWith({
    String? name,
    int? order,
    Color? color,
    bool? isActive,
    DateTime? createdAt,
    List<Hive>? hives,
  }) {
    return Apiary(
      id: this.id,
      name: name ?? this.name,
      order: order ?? this.order,
      color: color ?? this.color,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, order, color, isActive, createdAt];
}
