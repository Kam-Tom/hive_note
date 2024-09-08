part of 'dashboard_todos_bloc.dart';

sealed class DashboardTodosEvent extends Equatable {
  const DashboardTodosEvent();

  @override
  List<Object> get props => [];
}

final class DashboardTodosSubscriptionRequest extends DashboardTodosEvent {
  const DashboardTodosSubscriptionRequest();
}

final class DashboardTodosRetryRequest extends DashboardTodosEvent {
  const DashboardTodosRetryRequest();
}

final class DashboardTodosToggleIsComplete extends DashboardTodosEvent {
  const DashboardTodosToggleIsComplete({
    required this.todo,
    required this.isCompleted
  });

  final Todo todo;
  final bool isCompleted;

  @override
  List<Object> get props => [todo, isCompleted];
}