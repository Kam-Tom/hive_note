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

  Apiary({
    String? id,
    required this.name,
    this.latitude,
    this.longitude,
    required this.createdAt,
  }) : id = id ?? Uuid().v4();

  Apiary copyWith({
    String? name,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
  }) {
    return Apiary(
      id: this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
    );
  }
  
  @override
  List<Object?> get props => [id, name, latitude, longitude, createdAt];
}



