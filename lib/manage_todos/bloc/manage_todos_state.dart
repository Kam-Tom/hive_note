part of 'manage_todos_bloc.dart';

final class ManageTodosState extends InitialState {
  final List<Todo> todos;
  final DateTime selectedDate;
  final Todo todoForm;
  final bool isEditing;
  final Todo? editingTodo;

  const ManageTodosState({
    super.status,
    super.errorMessage,
    required this.todos,
    required this.selectedDate,
    required this.todoForm,
    required this.isEditing,
    required this.editingTodo,
  });

  @override
  List<Object?> get props => [todos, selectedDate, todoForm, isEditing, editingTodo, ...super.props];

  @override
  ManageTodosState copyWith({
    List<Todo>? todos,
    DateTime? selectedDate,
    Status? status,
    String? errorMessage,
    bool? isEditing,
    Todo? Function()? editingTodo,
    Todo? todoForm,
  }) {
    return ManageTodosState(
      status: status ?? super.status,
      errorMessage: errorMessage ?? super.errorMessage,
      todos: todos ?? this.todos,
      selectedDate: selectedDate ?? this.selectedDate,
      todoForm: todoForm ?? this.todoForm,
      isEditing: isEditing ?? this.isEditing,
      editingTodo: editingTodo != null ? editingTodo() : this.editingTodo,
    );
  }
}
