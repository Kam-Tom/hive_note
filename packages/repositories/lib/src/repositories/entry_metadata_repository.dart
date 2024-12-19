import 'package:app_database/app_database.dart';

class EntryMetadataRepository {
  final AppDatabase _database;
  const EntryMetadataRepository(AppDatabase database) : _database = database;

  Future<void> insertEntryMetadata(EntryMetadata entryMetadata) async {
    await _database.insertEntryMetadata(entryMetadata);
    await _database.insertHistoryLog(HistoryLog(
      referenceId: entryMetadata.id,
      logType: LogType.entry_metadata,
      actionType: ActionType.create,
      shadowLog: true,
    ));
  }
  Stream<List<EntryMetadata>> watchEntryMetadatasOfRaportType(RaportType raportType) => _database.watchEntryMetadatasOfRaportType(raportType);
  Future<void> deleteEntryMetadata(EntryMetadata entryMetadata) async {
    await _database.deleteEntryMetadata(entryMetadata);
    await _database.insertHistoryLog(
      HistoryLog(
        referenceId: entryMetadata.id,
        logType: LogType.entry_metadata,
        actionType: ActionType.delete,
        shadowLog: true,
      ),
    );
  } 

  Future<void> updateEntriesMetadata(List<EntryMetadata> entriesMetadata) async {
    await _database.updateEntriesMetadata(entriesMetadata);
    await Future.forEach(entriesMetadata, (entryMetadata) async {
      await _database.insertHistoryLog(
        HistoryLog(
          referenceId: entryMetadata.id,
          logType: LogType.entry_metadata,
          actionType: ActionType.update,
          shadowLog: true,
        ),
      );
    });
  } 

  Future<List<EntryMetadata>> getEntryMetadatas(RaportType raportType) => _database.getEntryMetadatas(raportType);
}
