import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class Todo extends Equatable {
  final String id;
  final String location;
  final String description;
  final CategoryType categoryType;
  final DateTime dueTo;
  final bool isCompleted;

  Todo({
    String? id,
    required this.location,
    required this.description,
    required this.categoryType,
    bool? isCompleted,
    required DateTime dueTo,
  })  : id = id ?? Uuid().v4(),
        dueTo = dueTo.copyWith(millisecond: 0, microsecond: 0),
        isCompleted = isCompleted ?? false;

  Todo copyWith({
    String? location,
    String? description,
    CategoryType? categoryType,
    bool? isCompleted,
    DateTime? dueTo,
  }) {
    return Todo(
      id: this.id,
      location: location ?? this.location,
      description: description ?? this.description,
      categoryType: categoryType ?? this.categoryType,
      isCompleted: isCompleted ?? this.isCompleted,
      dueTo: dueTo ?? this.dueTo,
    );
  }

  @override
  List<Object?> get props => [id, location, description, categoryType, isCompleted , dueTo];
}

enum CategoryType {
  feeding,
  inspection,
  treatment,
  harvest,
  winterize,
  sell,
  buy,
  queen,
  other,

}