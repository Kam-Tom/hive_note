import 'dart:math';

import 'package:app_database/app_database.dart';

class HistoryLogRepository {
  final AppDatabase _database;
  const HistoryLogRepository(AppDatabase database) : _database = database;

  // Future<void> insertHistoryLog(HistoryLog historyLog) {

  // }
  Future<List<HistoryLog>> getHistoryLogs(DateTime startDate, DateTime endDate, bool showShadow) async {
    return _database.getHistoryLogs(startDate, endDate, showShadow);
  }
  

}
