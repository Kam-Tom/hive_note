import 'package:app_database/app_database.dart';

class EntryMetadataRepository {
  final AppDatabase _database;
  const EntryMetadataRepository(AppDatabase database) : _database = database;

  Future<void> insertEntryMetadata(EntryMetadata entryMetadata) => _database.insertEntryMetadata(entryMetadata);
  Stream<List<EntryMetadata>> watchEntryMetadatasOfRaportType(RaportType raportType) => _database.watchEntryMetadatasOfRaportType(raportType);
  Future<void> deleteEntryMetadata(EntryMetadata entryMetadata) => _database.deleteEntryMetadata(entryMetadata);

  Future<void> updateEntriesMetadata(List<EntryMetadata> entriesMetadata) => _database.updateEntriesMetadata(entriesMetadata);

}
