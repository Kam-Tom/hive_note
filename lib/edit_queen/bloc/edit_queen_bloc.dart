import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_note/shared/bloc/helpers/initial_state.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';

part 'edit_queen_event.dart';
part 'edit_queen_state.dart';

class EditQueenBloc extends Bloc<EditQueenEvent, EditQueenState> {
  EditQueenBloc({
    required QueenRepository queenRepository,
  })  : _queenRepository = queenRepository,
        super(const EditQueenState()) {
    on<LoadQueen>(_onLoadQueen);
    on<UpdateQueenImmediate>(_onUpdateQueenImmediate);
    on<UpdateQueenDebounced>(
      _onUpdateQueenDebounced,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 500))
          .switchMap(mapper),
    );
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

  Future<void> _onUpdateQueenImmediate(UpdateQueenImmediate event, Emitter<EditQueenState> emit) async {
    try {
      await _queenRepository.updateQueen(
        state.queen!.copyWith(
          isAlive: event.isAlive ?? state.queen!.isAlive,
          birthDate: event.birthDate ?? state.queen!.birthDate,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onUpdateQueenDebounced(UpdateQueenDebounced event, Emitter<EditQueenState> emit) async {
    try {
      await _queenRepository.updateQueen(
        state.queen!.copyWith(
          breed: event.breed ?? state.queen!.breed,
          origin: event.origin ?? state.queen!.origin,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }
}
