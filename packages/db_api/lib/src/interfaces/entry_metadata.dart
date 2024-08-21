import 'package:db_api/db_api.dart';

abstract class EntryMetadataDbApi {

  Future<EntryMetadata> getEntryMetadata(String id);
  Future<List<EntryMetadata>> getEntryMetadataList();
  Stream<List<EntryMetadata>> watchEntryMetadataList();
  Future<void> insertEntryMetadata(EntryMetadata entryMetadata);
  Future<void> updateEntryMetadata(EntryMetadata entryMetadata);
  Future<void> deleteEntryMetadata(EntryMetadata entryMetadata);
}