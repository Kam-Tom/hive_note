import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_note/shared/bloc/helpers/initial_state.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:repositories/repositories.dart';

part 'edit_queen_event.dart';
part 'edit_queen_state.dart';

class EditQueenBloc extends Bloc<EditQueenEvent, EditQueenState> {
  EditQueenBloc({
    required QueenRepository queenRepository,
  })  : _queenRepository = queenRepository,
        super(const EditQueenState()) {
    on<LoadQueen>(_onLoadQueen);
    on<UpdateQueen>(_onUpdateQueen);
    on<ToggleEditing>(_onToggleEditing);
  }

  final QueenRepository _queenRepository;

  Future<void> _onLoadQueen(LoadQueen event, Emitter<EditQueenState> emit) async {
    emit(state.copyWith(status: Status.loading));

    await emit.forEach(
      _queenRepository.watchQueen(event.queenId),
      onData: (Queen queen) => state.copyWith(
        queen: queen,
        status: Status.success,
      ),
      onError: (_, __) => state.copyWith(status: Status.failure),
    );
  }

  Future<void> _onUpdateQueen(UpdateQueen event, Emitter<EditQueenState> emit) async {
    try {
      await _queenRepository.updateQueen(
        state.queen!.copyWith(
          breed: event.breed ?? state.queen!.breed,
          origin: event.origin ?? state.queen!.origin,
          isAlive: event.isAlive ?? state.queen!.isAlive,
          birthDate: event.birthDate ?? state.queen!.birthDate,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  void _onToggleEditing(ToggleEditing event, Emitter<EditQueenState> emit) {
    final newEditingState = Map<String, bool>.from(state.isEditing);
    newEditingState[event.field] = !(newEditingState[event.field] ?? false);
    emit(state.copyWith(isEditing: newEditingState));
  }
}
