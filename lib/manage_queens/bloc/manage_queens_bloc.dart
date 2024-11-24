import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:repositories/repositories.dart';

part 'manage_queens_event.dart';
part 'manage_queens_state.dart';

class ManageQueensBloc extends Bloc<ManageQueensEvent, ManageQueensState> {
  ManageQueensBloc({required QueenRepository queenRepository})
      : _queenRepository = queenRepository,
        super(const ManageQueensState()) {
    on<Subscribe>(_onSubscribe, transformer: restartable());
    on<SelectApiary>(_onSelectApiary);
    on<DeleteQueen>(_onDeleteHive);
    on<InsertQueen>(_onInsertHive);
  }

  final QueenRepository _queenRepository;

  Future<void> _onSubscribe(
    Subscribe event,
    Emitter<ManageQueensState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    await emit.forEach(
      _queenRepository.watchQueensWithHiveByApiary(state.selectedApiary),
      onData: (queens)  
      {
        return state.copyWith(
        queens: queens,
        status: Status.success,
        );
      },
      onError: (e, s) {
        return state.copyWith(status: Status.failure);
      }
    );
  }

  FutureOr<void> _onSelectApiary(
      SelectApiary event, Emitter<ManageQueensState> emit) {
    emit(state.copyWith(selectedApiary: () => event.apiary));

    add(const Subscribe());
  }

  FutureOr<void> _onDeleteHive(
      DeleteQueen event, Emitter<ManageQueensState> emit) async {
    var tmpQueens = List<QueenWithHive>.from(state.queens);

    tmpQueens.remove(event.queen);

    emit(state.copyWith(status: Status.updating, queens: tmpQueens));
    await _queenRepository.deleteQueen(event.queen.queen);
  }

  FutureOr<void> _onInsertHive(
      InsertQueen event, Emitter<ManageQueensState> emit) async {
    var tmpQueens = List<QueenWithHive>.from(state.queens);
    tmpQueens.add(QueenWithHive(queen: event.queen));
    emit(state.copyWith(status: Status.updating, queens: tmpQueens));
    await _queenRepository.insertQueen(event.queen);
  }
}
