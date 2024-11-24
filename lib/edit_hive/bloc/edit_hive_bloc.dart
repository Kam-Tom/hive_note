import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_note/shared/bloc/helpers/initial_state.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';

part 'edit_hive_event.dart';
part 'edit_hive_state.dart';

class EditHiveBloc extends Bloc<EditHiveEvent, EditHiveState> {
  EditHiveBloc({
    required HiveRepository hiveRepository,
    required QueenRepository queenRepository,
  })  : _hiveRepository = hiveRepository,
        _queenRepository = queenRepository,
        super(const EditHiveState()) {
    on<LoadHive>(_onLoadHive);
    on<LoadQueens>(_onLoadQueens);
    on<UpdateHiveDetails>(
      _onUpdateHiveDetails,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 750))
          .switchMap(mapper),
    );
    on<UpdateHiveQueen>(_onUpdateHiveQueen);
    on<CreateNewQueen>(_onCreateNewQueen);
    on<SelectApiary>(_onSelectApiary);
  }

  final HiveRepository _hiveRepository;
  final QueenRepository _queenRepository;

  Future<void> _onLoadHive(LoadHive event, Emitter<EditHiveState> emit) async {
    if (state.status != Status.loading) {
      emit(state.copyWith(status: Status.loading));
    }

    await emit.forEach(
      _hiveRepository.watchHiveWithQueen(event.hiveId),
      onData: (HiveWithQueen data) {
        
        return state.copyWith(
          hive: data.hive,
          queen: data.queen,
          status: Status.success,
        );
      },
      onError: (_, __) => state.copyWith(status: Status.failure),
    );
  }

  Future<void> _onLoadQueens(LoadQueens event, Emitter<EditHiveState> emit) async {
    await emit.forEach(
      _queenRepository.watchAvailableQueens(),
      onData: (List<Queen> queens) => state.copyWith(
        availableQueens: queens,
        status: Status.success,
      ),
      onError: (_, __) => state.copyWith(status: Status.failure),
    );
  }

  Future<void> _onUpdateHiveDetails(UpdateHiveDetails event, Emitter<EditHiveState> emit) async {
    if (state.hive == null) return;
    try {
      final updatedHive = state.hive!.copyWith(
        name: event.name ?? state.hive!.name,
        type: event.type ?? state.hive!.type,
      );
      await _hiveRepository.updateHive(updatedHive);
      emit(state.copyWith(hive: updatedHive));
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onUpdateHiveQueen(UpdateHiveQueen event, Emitter<EditHiveState> emit) async {
    Queen? queen;

    if(event.queenId != null && event.queenId != state.queen?.id) {
      queen = state.availableQueens.firstWhere((q) => q.id == event.queenId);
    }

    if(queen == state.queen) return;

    try {
      if (queen != null) {
        // First update the queen with new hive ID
        final newQueen = queen.copyWith(hiveId: () => state.hive!.id);
        if(state.queen != null) {
          await _queenRepository.updateQueen(state.queen!.copyWith(hiveId: () => null));
        }
        await _queenRepository.updateQueen(newQueen);
        
        // Then emit state with the updated queen
        emit(state.copyWith(
          queen: newQueen,
          availableQueens: state.availableQueens.where((q) => q.id != queen!.id).toList(),
          status: Status.success,
        ));
      } else if(state.queen != null) {
        // Remove queen from hive
        final removedQueen = state.queen!.copyWith(hiveId: () => null);
        await _queenRepository.updateQueen(removedQueen);
        
        // Then emit state with no queen and add the queen back to available queens
        emit(state.copyWith(
          queen: null,
          availableQueens: [...state.availableQueens, removedQueen],
          status: Status.success,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onCreateNewQueen(CreateNewQueen event, Emitter<EditHiveState> emit) async {
    try {
      final queen = Queen(
        breed: event.defaultBreed,
        origin: event.defaultOrigin,
        isAlive: true,
        birthDate: DateTime.now(),
        hiveId: state.hive!.id,
      );
      if(state.queen != null) {
        await _queenRepository.updateQueen(state.queen!.copyWith(hiveId: () => null));
      }
      await _queenRepository.insertQueen(queen);
      emit(state.copyWith(insertedQueenId: queen.id, queen: queen, availableQueens: [...state.availableQueens, queen]));
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  FutureOr<void> _onSelectApiary(SelectApiary event, Emitter<EditHiveState> emit) {
    final updatedHive = state.hive!.copyWith(apiaryId: () => event.apiary?.id);
    emit(state.copyWith(hive: updatedHive));
    _hiveRepository.updateHive(updatedHive);
  }

}
