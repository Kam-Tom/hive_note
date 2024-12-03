import 'package:app_database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift_app_database/drift_app_database.dart';
import 'package:drift_app_database/src/tabels/tabels.dart';

part 'entry_metadata_dao.g.dart';

@DriftAccessor(tables: [EntryMetadataTable])
class EntryMetadataDao extends DatabaseAccessor<DriftAppDatabase>
    with _$EntryMetadataDaoMixin {
  EntryMetadataDao(DriftAppDatabase db) : super(db);

  Stream<List<EntryMetadata>> watchEntryMetadatasOfRaportType(RaportType raportType) {
    final query = (select(entryMetadataTable)
          ..where((tbl) => tbl.raportType.equals(raportType.index))
          ..orderBy([(t) => OrderingTerm(expression: t.order)]))
        .watch();

    return query;
  }

  Future insertEntryMetadata(EntryMetadata entryMetadata) =>
      into(entryMetadataTable).insert(entryMetadata.toCompanion());
  
  Future deleteEntryMetadata(EntryMetadata entryMetadata) =>
      (delete(entryMetadataTable)..where((t) => t.id.equals(entryMetadata.id))).go();

  Future updateEntriesMetadata(List<EntryMetadata> entriesMetadata) {
    return batch((batch) {
      batch.replaceAll(entryMetadataTable,
          entriesMetadata.map((entry) => entry.toCompanion()));
    });
  }

  Future<List<EntryMetadata>> getEntryMetadatas(RaportType raportType) {
    final query = (select(entryMetadataTable)
          ..where((tbl) => tbl.raportType.equals(raportType.index))
          ..orderBy([(t) => OrderingTerm(expression: t.order)]))
        .get();

    return query;
  }
}

extension on EntryMetadata {
  EntryMetadataTableCompanion toCompanion() {
    return EntryMetadataTableCompanion(
      id: Value(id),
      label: Value(label),
      order: Value(order),
      hint: Value(hint),
      valueType: Value(valueType),
      raportType: Value(raportType),
    );
  }
}
