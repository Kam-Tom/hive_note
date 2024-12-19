import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_note/shared/bloc/helpers/initial_state.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:repositories/repositories.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({
    required HistoryLogRepository historyLogRepository,
    required HiveRepository hiveRepository,
    required ApiaryRepository apiaryRepository,
    required QueenRepository queenRepository,
    

  }) :
    _historyLogRepository = historyLogRepository,
      super(HistoryState(startDate: DateTime.now().subtract(const Duration(days:7)), endDate: DateTime.now())) {
    on<LoadData>(_onLoadData);
    on<ChangeDate>(_onChangeDate);
    on<ChangeType>(_onChangeType);
    on<OpenLog>(_onOpenLog);
  }

  final HistoryLogRepository _historyLogRepository;

  Future<void> _onLoadData(LoadData event, Emitter<HistoryState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final historyLogs = await _historyLogRepository.getHistoryLogs(state.startDate, state.endDate, false);
      
      //final filtredLogs = historyLogs.where((element) => state.tableTypes.contains(element.tableType)).toList();

      emit(state.copyWith(
        historyLogs: historyLogs,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  FutureOr<void> _onChangeDate(ChangeDate event, Emitter<HistoryState> emit) async {
    final endDate = DateTime(event.endDate.year, event.endDate.month, event.endDate.day, 23, 59, 59);
    emit(state.copyWith(
      startDate: event.startDate,
      endDate: endDate,
      status: Status.loading,
    ));
    try {
      final historyLogs = await _historyLogRepository.getHistoryLogs(event.startDate, endDate,false);
      //final filtredLogs = historyLogs.where((element) => state.tableTypes.contains(element.tableType)).toList();
      emit(state.copyWith(
        historyLogs: historyLogs,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  FutureOr<void> _onChangeType(ChangeType event, Emitter<HistoryState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      List<LogType> newLogTypes = List.from(state.logTypes);
      if (event.selected) {
        newLogTypes.add(event.logType);
      } else {
        newLogTypes.remove(event.logType);
      }

      final historyLogs = await _historyLogRepository.getHistoryLogs(state.startDate, state.endDate, false);
      
      final filteredLogs = newLogTypes.isEmpty 
          ? historyLogs 
          : historyLogs.where((element) => newLogTypes.contains(element.logType)).toList();
      
      emit(state.copyWith(
        historyLogs: filteredLogs,
        logTypes: newLogTypes,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  FutureOr<void> _onOpenLog(OpenLog event, Emitter<HistoryState> emit) {
  }
}
