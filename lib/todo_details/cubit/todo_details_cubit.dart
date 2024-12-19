import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';

part 'todo_details_state.dart';

class TodoDetailsCubit extends Cubit<TodoDetailsState> {
  TodoDetailsCubit({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository,
       super(TodoDetailsInitial());

  final TodoRepository _todoRepository;

  Future<void> loadTodoDetails(String todoId) async {
    emit(TodoDetailsLoading());
    try {
      final todo = await _todoRepository.getTodo(todoId);
      emit(TodoDetailsSuccess(todo: todo));
    } catch (e) {
      emit(TodoDetailsError(e.toString()));
    }
  }
}
