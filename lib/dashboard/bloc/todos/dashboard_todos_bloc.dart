import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';

part 'dashboard_todos_event.dart';
part 'dashboard_todos_state.dart';

class DashboardTodosBloc
    extends Bloc<DashboardTodosEvent, DashboardTodosState> {
  final TodoRepository _todoRepository;

  DashboardTodosBloc({
    required TodoRepository todoRepository,
  })  : _todoRepository = todoRepository,
        super(const DashboardTodosState(todos: [])) {
    on<DashboardTodosSubscriptionRequest>(_onSubscriptionRequest);
    on<DashboardTodosToggleIsComplete>(_onCompletionToggled);
    on<DashboardTodosRetryRequest>(_onRetryRequest);
  }

  Future<void> _onSubscriptionRequest(
    DashboardTodosSubscriptionRequest event,
    Emitter<DashboardTodosState> emit,
  ) async {
    emit(state.copyWith(status: DashboardTodosStatus.loading));

    await emit.forEach<List<Todo>>(
      _todoRepository.watchNotCompletedTodos(),
      onData: (todos) => state.copyWith(
        status: todos.isEmpty
            ? DashboardTodosStatus.empty
            : DashboardTodosStatus.success,
        todos: todos,
      ),
      onError: (_, __) => state.copyWith(
        status: DashboardTodosStatus.failure,
      ),
    );
  }

  Future<void> _onCompletionToggled(
      DashboardTodosToggleIsComplete event,
      Emitter<DashboardTodosState> emit,
    ) async {
      final todo = event.todo.copyWith(isCompleted: event.isCompleted);
      await _todoRepository.updateTodo(todo);
    }

  Future<void> _onRetryRequest(
    DashboardTodosRetryRequest event,
    Emitter<DashboardTodosState> emit,
  ) async {
    add(const DashboardTodosSubscriptionRequest());
  }
}
