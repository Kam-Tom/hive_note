import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class HistoryLog extends Equatable {
  final String id;
  final String referenceId; // id of the changed object
  final LogType logType;
  final ActionType actionType;
  final DateTime createdAt;
  final bool shadowLog;

  HistoryLog({
    String? id,
    required this.referenceId,
    required this.logType,
    required this.actionType,
    this.shadowLog = false,
    DateTime? createdAt,
  }) : id = id ?? Uuid().v4(),
  createdAt = (createdAt ?? DateTime.now()).copyWith(millisecond: 0, microsecond: 0);
  
  @override
  List<Object?> get props => [id, referenceId, logType, actionType, createdAt,shadowLog];
}

enum LogType {
  apiary,
  hive,
  queen,
  todo,
  entry_metadata,
  entry,

  inspection,
  harvest,
  treatment,
  note,
  finances,
  feeding,

}

enum ActionType {
  create,
  update,
  delete,
}