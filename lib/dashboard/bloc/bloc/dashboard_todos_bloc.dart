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
    on<DashboardTodosSubscriptionRequested>(_onSubscriptionRequested);
  }

  Future<void> _onSubscriptionRequested(
    DashboardTodosSubscriptionRequested event,
    Emitter<DashboardTodosState> emit,
  ) async {
    emit(state.copyWith(status: DashboardTodosStatus.loading));

    await emit.forEach<List<Todo>>(
      _todoRepository.watchTodos(),
      onData: (todos) => state.copyWith(
        status: todos.isEmpty
            ? DashboardTodosStatus.success
            : DashboardTodosStatus.empty,
        todos: todos,
      ),
      onError: (_, __) => state.copyWith(
        status: DashboardTodosStatus.failure,
      ),
    );
  }
}
