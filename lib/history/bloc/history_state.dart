part of 'history_bloc.dart';

final class HistoryState extends InitialState {
  const HistoryState({
    this.historyLogs = const [],
    required this.endDate,
    required this.startDate,
    this.logTypes = const [LogType.apiary,LogType.hive,LogType.queen,LogType.todo,LogType.feeding, LogType.finances,LogType.harvest,LogType.inspection,LogType.note,LogType.treatment],
    super.status,
    super.errorMessage,
  });

  final List<HistoryLog> historyLogs;
  final DateTime endDate;
  final DateTime startDate;
  final List<LogType> logTypes;
  
  @override
  List<Object?> get props => [historyLogs, status, errorMessage];

  @override
  HistoryState copyWith({
    List<HistoryLog>? historyLogs,
    DateTime? endDate,
    DateTime? startDate,
    List<LogType>? logTypes,
    Status? status,
    String? errorMessage,
  }) {
    return HistoryState(
      historyLogs: historyLogs ?? this.historyLogs,
      endDate: endDate ?? this.endDate,
      startDate: startDate ?? this.startDate,
      logTypes: logTypes ?? this.logTypes,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,  
    );
  }
}
