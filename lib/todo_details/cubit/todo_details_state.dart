part of 'todo_details_cubit.dart';

sealed class TodoDetailsState extends Equatable {
  const TodoDetailsState();

  @override
  List<Object?> get props => [];
}

final class TodoDetailsInitial extends TodoDetailsState {}

final class TodoDetailsLoading extends TodoDetailsState {}

final class TodoDetailsSuccess extends TodoDetailsState {
  final Todo todo;

  const TodoDetailsSuccess({
    required this.todo,
  });

  @override
  List<Object?> get props => [todo];
}

final class TodoDetailsError extends TodoDetailsState {
  final String message;

  const TodoDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
