part of 'manage_queens_bloc.dart';

sealed class ManageQueensEvent extends Equatable {
  const ManageQueensEvent();

  @override
  List<Object?> get props => [];
}

final class Subscribe extends ManageQueensEvent {
  const Subscribe();
}

final class SelectApiary extends ManageQueensEvent {
  const SelectApiary({required this.apiary});

  final Apiary? apiary;

  @override
  List<Object?> get props => [apiary];
}

final class DeleteQueen extends ManageQueensEvent {
  const DeleteQueen({required this.queen});

  final QueenWithHive queen;

  @override
  List<Object> get props => [queen];
}

final class InsertQueen extends ManageQueensEvent {
  const InsertQueen({required this.queen});

  final Queen queen;

  @override
  List<Object> get props => [queen];
}