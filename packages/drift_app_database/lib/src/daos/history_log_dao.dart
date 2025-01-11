import 'package:app_database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift_app_database/drift_app_database.dart';
import 'package:drift_app_database/src/tabels/tabels.dart';

part 'history_log_dao.g.dart';

@DriftAccessor(tables: [HistoryLogTable])
class HistoryLogDao extends DatabaseAccessor<DriftAppDatabase>
    with _$HistoryLogDaoMixin {
  HistoryLogDao(DriftAppDatabase db) : super(db);

  Future<List<HistoryLog>> getHistoryLogs(DateTime startDate, DateTime endDate, bool showShadow) 
  {
    final query = select(historyLogTable)
      ..where((tbl) => tbl.createdAt.isSmallerOrEqualValue(endDate))
      ..where((tbl) => tbl.createdAt.isBiggerOrEqualValue(startDate))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)]);
    if(!showShadow){
      query.where((tbl) => tbl.shadowLog.equals(false));
    }
    return query.get();

  }

  Future insertHistoryLog(HistoryLog historyLog) => into(historyLogTable).insert(historyLog.toCompanion());

}

extension on HistoryLog {
  HistoryLogTableCompanion toCompanion() {
    return HistoryLogTableCompanion(
      id: Value(id),
      referenceId: Value(referenceId),
      logType: Value(logType),
      actionType: Value(actionType),
      createdAt: Value(createdAt),
      shadowLog: Value(shadowLog),
    );
  }
}
