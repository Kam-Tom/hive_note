part of 'dashboard_todos_bloc.dart';

enum DashboardTodosStatus { empty, loading, success, failure }
final class DashboardTodosState extends Equatable {
  const DashboardTodosState({
    this.todos = const [],
    this.status = DashboardTodosStatus.empty,
  });
  final List<Todo> todos;
  final DashboardTodosStatus status;

  copyWith({
    List<Todo>? todos,
    DashboardTodosStatus? status,
  }) {
    return DashboardTodosState(
      todos: todos ?? this.todos,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [todos, status];
}

