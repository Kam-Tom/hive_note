import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_note/shared/bloc/helpers/initial_state.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:repositories/repositories.dart';

part 'manage_todos_event.dart';
part 'manage_todos_state.dart';

class ManageTodosBloc extends Bloc<ManageTodosEvent, ManageTodosState> {
  final TodoRepository _todoRepository;

  ManageTodosBloc({required TodoRepository todoRepository})
      : _todoRepository = todoRepository,
        super(ManageTodosState(
          status: Status.initial,
          todos: const [],
          selectedDate: DateTime.now(),
          isEditing: false,
          editingTodo: null,
          todoForm: Todo(
            description: '',
            location: '',
            categoryType: CategoryType.other,
            dueTo: DateTime.now(),
          ),
          focusedDate: DateTime.now(),
        )) {
    on<LoadTodos>(_onLoadTodos);
    on<CreateTodo>(_onCreateTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<SelectDate>(_onSelectDate);
    on<EditTodoEvent>(_onEditTodo);
    on<StartEditTodoEvent>(_onStartEditTodo);
    on<CancelEditTodoEvent>(_onCancelEditTodo);
    on<UpdateTodoFormEvent>(_onUpdateTodoForm);
  }

  Future<void> _onLoadTodos(LoadTodos event, Emitter<ManageTodosState> emit) async {
    emit(state.copyWith(status: Status.loading));

    await emit.forEach(
      _todoRepository.watchTodos(), 
      onData: (List<Todo> todos) {
        return state.copyWith(status: Status.success, todos: todos);
      },
      onError: (_, __) {
        return state.copyWith(status: Status.failure, errorMessage: 'Failed to load todos');
      },
    );
  }

  Future<void> _onCreateTodo(CreateTodo event, Emitter<ManageTodosState> emit) async {
    try {
      await _todoRepository.insertTodo(event.todo);
    } catch (_) {
      emit(state.copyWith(status: Status.failure, errorMessage: 'Failed to create todo'));
    }
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<ManageTodosState> emit) async {
    try {
      await _todoRepository.removeTodo(event.todo);
      emit(state.copyWith(
        editingTodo: () => null,
        isEditing: false,
        todoForm: Todo(
          description: '',
          location: '',
          categoryType: CategoryType.other,
          dueTo: DateTime.now(),
        ),
      ));
    } catch (_) {
      emit(state.copyWith(status: Status.failure, errorMessage: 'Failed to delete todo'));
    }
  }

  void _onSelectDate(SelectDate event, Emitter<ManageTodosState> emit) {
    emit(state.copyWith(
      selectedDate: event.selectedDate,
      focusedDate: event.selectedDate,
      editingTodo: () => null,
      isEditing: false,
      todoForm: Todo(
        description: '',
        location: '',
        categoryType: CategoryType.other,
        dueTo: event.selectedDate,
      ),
    ));
  }

  void _onEditTodo(EditTodoEvent event, Emitter<ManageTodosState> emit) {
    emit(state.copyWith(
      editingTodo: () => event.todo,
      isEditing: false,
      todoForm: event.todo,
    ));
  }

  void _onStartEditTodo(StartEditTodoEvent event, Emitter<ManageTodosState> emit) {
    emit(state.copyWith(isEditing: true));
  }

  void _onCancelEditTodo(CancelEditTodoEvent event, Emitter<ManageTodosState> emit) {
    emit(state.copyWith(
      isEditing: false,
      todoForm: state.editingTodo!,
    ));
  }

  void _onUpdateTodoForm(UpdateTodoFormEvent event, Emitter<ManageTodosState> emit) {
    final updatedForm = state.todoForm.copyWith(
      description: event.description ?? state.todoForm.description,
      location: event.location ?? state.todoForm.location,
      categoryType: event.categoryType ?? state.todoForm.categoryType,
    );
    emit(state.copyWith(todoForm: updatedForm));
  }

  Future<void> _onUpdateTodo(UpdateTodo event, Emitter<ManageTodosState> emit) async {
    try {
      await _todoRepository.updateTodo(event.todo);
      emit(state.copyWith(
        isEditing: false,
        editingTodo: () => event.todo,
        todoForm: event.todo,
      ));
    } catch (_) {
      emit(state.copyWith(status: Status.failure, errorMessage: 'Failed to update todo'));
    }
  }
}
