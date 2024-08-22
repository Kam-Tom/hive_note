import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class HistoryLog extends Equatable {
  final String id;
  final String referenceId; // id of the changed object
  final TableType tableType;
  final ActionType actionType;
  final DateTime createdAt;

  HistoryLog({
    String? id,
    required this.referenceId,
    required this.tableType,
    required this.actionType,
    required DateTime createdAt,
  }) : id = id ?? Uuid().v4(),
  createdAt = createdAt.copyWith(millisecond: 0, microsecond: 0);

  HistoryLog copyWith({
    String? referenceId,
    TableType? tableType,
    ActionType? actionType,
    DateTime? createdAt,
  }) {
    return HistoryLog(
      id: this.id,
      referenceId: referenceId ?? this.referenceId,
      tableType: tableType ?? this.tableType,
      actionType: actionType ?? this.actionType,
      createdAt: createdAt ?? this.createdAt,
    );
  }
  
  @override
  List<Object?> get props => [id, referenceId, tableType, actionType, createdAt];
}

enum TableType {
  apiary,
  boolean_entry,
  entry_metadata,
  hive,
  numeric_entry,
  queen,
  raport,
  text_entry,
}

enum ActionType {
  create,
  update,
  delete,
}