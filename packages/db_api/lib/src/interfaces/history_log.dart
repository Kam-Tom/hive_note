import 'package:db_api/db_api.dart';

abstract class HistoryLogDbApi {

  Future<HistoryLog> getHistoryLog(String id);
  Future<List<HistoryLog>> getHistoryLogs();
  Stream<List<HistoryLog>> watchHistoryLogs();
  Future<void> insertHistoryLog(HistoryLog historyLog);
  Future<void> deleteHistoryLog(HistoryLog historyLog);
}