part of 'manage_todos_bloc.dart';

sealed class ManageTodosEvent extends Equatable {
  const ManageTodosEvent();

  @override
  List<Object?> get props => [];
}

final class LoadTodos extends ManageTodosEvent {}

final class UpdateTodo extends ManageTodosEvent {
  final Todo todo;

  const UpdateTodo({required this.todo});

  @override
  List<Object?> get props => [todo];
}

final class SelectDate extends ManageTodosEvent {
  final DateTime selectedDate;

  const SelectDate({required this.selectedDate});

  @override
  List<Object?> get props => [selectedDate];
}

final class CreateTodo extends ManageTodosEvent {
  final Todo todo;

  const CreateTodo({required this.todo});

  @override
  List<Object?> get props => [todo];
}

final class DeleteTodo extends ManageTodosEvent {
  final Todo todo;

  const DeleteTodo({required this.todo});

  @override
  List<Object?> get props => [todo];
}

final class EditTodoEvent extends ManageTodosEvent {
  final Todo todo;

  const EditTodoEvent({required this.todo});

  @override
  List<Object?> get props => [todo];
}

final class StartEditTodoEvent extends ManageTodosEvent {}

final class CancelEditTodoEvent extends ManageTodosEvent {}

final class UpdateTodoFormEvent extends ManageTodosEvent {
  final String? description;
  final String? location;
  final CategoryType? categoryType;

  const UpdateTodoFormEvent({this.description, this.location, this.categoryType});

  @override
  List<Object?> get props => [description, location, categoryType];
}
