part of 'dashboard_todos_bloc.dart';

sealed class DashboardTodosEvent extends Equatable {
  const DashboardTodosEvent();

  @override
  List<Object> get props => [];
}

final class DashboardTodosSubscriptionRequested extends DashboardTodosEvent {
  const DashboardTodosSubscriptionRequested();
}

final class DashboardTodosCompletionToggled extends DashboardTodosEvent {
  const DashboardTodosCompletionToggled({
    required this.todo,
    required this.isCompleted,
  });

  final Todo todo;
  final bool isCompleted;

  @override
  List<Object> get props => [todo, isCompleted];
}