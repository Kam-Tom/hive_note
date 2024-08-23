import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class Queen extends Equatable {
  final String id;
  final String breed;
  final String origin;
  final DateTime birthDate;
  final bool isAlive;

  Queen({
    String? id,
    required this.breed,
    required this.origin,
    required this.isAlive,
    required DateTime birthDate,
  })  : id = id ?? Uuid().v4(),
        birthDate = birthDate.copyWith(millisecond: 0, microsecond: 0);

  Queen copyWith({
    String? breed,
    String? origin,
    DateTime? birthDate,
    bool? isAlive,
  }) {
    return Queen(
      id: this.id,
      breed: breed ?? this.breed,
      origin: origin ?? this.origin,
      birthDate: birthDate ?? this.birthDate,
      isAlive: isAlive ?? this.isAlive,
    );
  }

  @override
  List<Object?> get props => [id, breed, origin, isAlive, birthDate];
}