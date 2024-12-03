import 'package:app_database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift_app_database/drift_app_database.dart';
import 'package:drift_app_database/src/tabels/tabels.dart';

part 'raport_dao.g.dart';

@DriftAccessor(tables: [RaportTable, EntryTable])
class RaportDao extends DatabaseAccessor<DriftAppDatabase>
    with _$RaportDaoMixin {
  RaportDao(DriftAppDatabase db) : super(db);

  Future<void> updateRaport(Raport raport, List<Entry> entries) async {
    await transaction(() async {
      // Update raport
      await update(raportTable).replace(raport.toCompanion());

      final entriesCompanions = entries.map((e) => e.toCompanion());
      await batch((batch) {
        batch.insertAll(entryTable, entriesCompanions);
      });

    });
  }

  Future<void> insertRaport(Raport raport, List<Entry> entries) async {
    await transaction(() async {
      // Insert raport
      await into(raportTable).insert(raport.toCompanion());
      
      // Insert all entries
      final entriesCompanions = entries.map((e) => e.toCompanion());
      await batch((batch) {
        batch.insertAll(entryTable, entriesCompanions);
      });
    });
  }

  Future<void> deleteRaport(Raport raport) async {
    (delete(raportTable)..where((tbl) => tbl.id.equals(raport.id))).go();
  }

}

extension on Raport {
  RaportTableCompanion toCompanion() {
    return RaportTableCompanion(
      id: Value(id),
      hiveId: Value(hiveId),
      apiaryId: Value(apiaryId),
      createdAt: Value(createdAt),
    );
  }
}

extension on Entry {
  EntryTableCompanion toCompanion() {
    return EntryTableCompanion(
      id: Value(id),
      raportId: Value(raportId),
      entryMetadataId: Value(entryMetadataId),
      value: Value(value)
    );
  }
}
