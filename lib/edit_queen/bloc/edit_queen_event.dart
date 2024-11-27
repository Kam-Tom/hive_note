part of 'edit_queen_bloc.dart';

sealed class EditQueenEvent extends Equatable {
  const EditQueenEvent();
}

final class LoadQueen extends EditQueenEvent {
  const LoadQueen({required this.queenId});
  final String queenId;

  @override
  List<Object?> get props => [queenId];
}

final class UpdateQueen extends EditQueenEvent {
  const UpdateQueen({
    this.breed,
    this.origin,
    this.isAlive,
    this.birthDate,
  });

  final String? breed;
  final String? origin;
  final bool? isAlive;
  final DateTime? birthDate;

  @override
  List<Object?> get props => [breed, origin, isAlive, birthDate];
}

final class ToggleEditing extends EditQueenEvent {
  const ToggleEditing(this.field);

  final String field;

  @override
  List<Object?> get props => [field];
}