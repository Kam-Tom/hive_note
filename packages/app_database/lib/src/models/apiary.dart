import 'package:app_database/app_database.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class Apiary extends Equatable {
  final String id;
  final String name;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;
  final List<Hive> hives;

  Apiary({
    String? id,
    required this.name,
    this.latitude,
    this.longitude,
    required DateTime createdAt,
    this.hives = const [],
  })  : id = id ?? Uuid().v4(),
        createdAt = createdAt.copyWith(millisecond: 0, microsecond: 0);

  Apiary copyWith({
    String? name,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
    List<Hive>? hives,
  }) {
    return Apiary(
      id: this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      hives: hives ?? this.hives,
    );
  }

  @override
  List<Object?> get props => [id, name, latitude, longitude, createdAt, hives];
}
