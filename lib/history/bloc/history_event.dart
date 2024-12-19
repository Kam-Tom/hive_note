part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadData extends HistoryEvent {
  const LoadData();
}

class ChangeDate extends HistoryEvent {
  const ChangeDate({
    required this.startDate,
    required this.endDate,
  });

  final DateTime startDate;
  final DateTime endDate;

  @override
  List<Object?> get props => [startDate, endDate];
}

class ChangeType extends HistoryEvent {
  const ChangeType({
    required this.logType,
    required this.selected,
  });

  final LogType logType;
  final bool selected;

  @override
  List<Object?> get props => [logType, selected];
}

class OpenLog extends HistoryEvent {
  const OpenLog({required this.log});

  final HistoryLog log;

  @override
  List<Object?> get props => [log];
}

class ChangeApiaryFilter extends HistoryEvent {
  const ChangeApiaryFilter({
    required this.apiaryId,
    required this.selected,
  });

  final String apiaryId;
  final bool selected;

  @override
  List<Object?> get props => [apiaryId, selected];
}

class ChangeHiveFilter extends HistoryEvent {
  const ChangeHiveFilter({
    required this.hiveId,
    required this.selected,
  });

  final String hiveId;
  final bool selected;

  @override
  List<Object?> get props => [hiveId, selected];
}

class ChangeQueenFilter extends HistoryEvent {
  const ChangeQueenFilter({
    required this.queenId,
    required this.selected,
  });

  final String queenId;
  final bool selected;

  @override
  List<Object?> get props => [queenId, selected];
}
