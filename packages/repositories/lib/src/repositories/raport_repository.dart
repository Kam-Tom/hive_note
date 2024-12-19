import 'package:app_database/app_database.dart';

class RaportRepository {
  final AppDatabase _database;
  const RaportRepository(AppDatabase database) : _database = database;

  Future<void> insertRaport(Raport raport, List<Entry> entries) async {
    await _database.insertRaport(raport, entries);

    await _database.insertHistoryLog(
      HistoryLog(
        referenceId: raport.id,
        logType: raport.raportType.toLogType(),
        actionType: ActionType.create,
      ),
    );
    for (final entry in entries) {
      await _database.insertHistoryLog(
        HistoryLog(
          referenceId: entry.id,
          logType: LogType.entry,
          actionType: ActionType.create,
          shadowLog: true
        ),
      );
    }
  }
  Future<void> updateRaport(Raport raport, List<Entry> entries) async {
    await _database.updateRaport(raport, entries);

    await _database.insertHistoryLog(
      HistoryLog(
        referenceId: raport.id,
        logType: raport.raportType.toLogType(),
        actionType: ActionType.create,
      ),
    );
    for (final entry in entries) {
      await _database.insertHistoryLog(
        HistoryLog(
          referenceId: entry.id,
          logType: LogType.entry,
          actionType: ActionType.create,
          shadowLog: true
        ),
      );
    }
  }
  Future<void> deleteRaport(Raport raport) async {
    await _database.deleteRaport(raport);

    await _database.insertHistoryLog(
      HistoryLog(
        referenceId: raport.id,
        logType: raport.raportType.toLogType(),
        actionType: ActionType.delete,
      ),
    );

  }

Future<Map<Raport, List<Entry>>> getData(
  RaportType raportType,
  DateTime? startDate,
  DateTime? endDate,
  Map<String, List<String>>? filters,
  List<Hive>? hives,
  List<Apiary>? apiaries,
) async {
  final raports = await _database.getRaports(
    raportType,
    startDate,
    endDate,
    apiaries,
    hives,
  );

  final result = <Raport, List<Entry>>{};

  for (final raport in raports) {
    final raportEntries = await _database.getEntries(raport);
    bool addRaport = filters == null || filters.isEmpty;

    if (filters != null && filters.isNotEmpty) {
      for (final entry in raportEntries) {
        final filterValues = filters[entry.entryMetadataId];
        if (filterValues != null && filterValues.contains(entry.value)) {
          addRaport = true;
          break;
        }
      }
    }

    if (addRaport) {
      result[raport] = raportEntries;
    }
  }

  return result;
}

  Future<Map<String,List<String>>> getHints(RaportType raportType, {bool withCount = false}) async {
    return await _database.getHints(raportType,withCount);
  }
Future<Map<String,List<String>>> getFinanceItems() async {
    final financesHints = await _database.getHints(RaportType.finances, false);
    final harvestHints = await _database.getHints(RaportType.harvest, false);
    
    final List<String> finalHints = [];
    
    // Add existing finance hints if any
    if (financesHints["transaction_item"] != null) {
        finalHints.addAll(financesHints["transaction_item"]!);
    }
    
    // Add harvest honey_type hints if any
    if (harvestHints["honey_type"] != null) {
        finalHints.addAll(harvestHints["honey_type"]!);
    }
    
    financesHints["transaction_item"] = finalHints;
    return financesHints;
}

  Future<Raport> getRaport(String raportId) => _database.getRaport(raportId);

  Future<List<Entry>> getEntries(Raport raport) => _database.getEntries(raport);

}
extension FirstWhereOrNullExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}