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

final class UpdateQueenImmediate extends EditQueenEvent {
  const UpdateQueenImmediate({
    this.isAlive,
    this.birthDate,
  });

  final bool? isAlive;
  final DateTime? birthDate;

  @override
  List<Object?> get props => [isAlive, birthDate];
}

final class UpdateQueenDebounced extends EditQueenEvent {
  const UpdateQueenDebounced({
    this.breed,
    this.origin,
  });

  final String? breed;
  final String? origin;

  @override
  List<Object?> get props => [breed, origin];
}