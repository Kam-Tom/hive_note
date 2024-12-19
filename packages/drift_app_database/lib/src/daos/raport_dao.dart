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

  Future<Raport> getRaport(String raportId) => (select(raportTable)..where((tbl) => tbl.id.equals(raportId))).getSingle();

  Future<List<Entry>> getEntries(Raport raport) => (select(entryTable)..where((tbl) => tbl.raportId.equals(raport.id))).get();

  Future<Map<String,List<String>>> getHints(RaportType raportType, bool withCount) async {
    final raports = await (select(raportTable)..where((tbl) => tbl.raportType.equals(raportType.index))).get();
    final metadatas = await (select(entryMetadataTable)..where((tbl) => tbl.raportType.equals(raportType.index))).get();
    final entries = await (select(entryTable)..where((tbl) => tbl.raportId.isIn(raports.map((e) => e.id)))).get();

    final hints = <String, List<String>>{};
    for (final metadata in metadatas) {
      var values;
      if (withCount) {
        var withDuplicates = entries.where((e) => e.entryMetadataId == metadata.id).map((e) => e.value).toList();
        var valueCounts = <String, int>{};
        for (var value in withDuplicates) {
          valueCounts[value] = (valueCounts[value] ?? 0) + 1;
        }

        values = valueCounts.entries.map((entry) => '${entry.key} (${entry.value})').toList();
      } else {
        values = entries.where((e) => e.entryMetadataId == metadata.id).map((e) => e.value).toSet().toList();
      }
      hints[metadata.id] = values;
    }

    return hints;  
  }

  Future<List<Raport>> getRaports(RaportType raportType, DateTime? startDate, DateTime? endDate, List<Apiary>? apiaries, List<Hive>? hives) async {
    final query = select(raportTable)..where((tbl) => tbl.raportType.equals(raportType.index));
    if (startDate != null) {
      query.where((tbl) => tbl.createdAt.isBiggerOrEqualValue(startDate));
    }
    if (endDate != null) {
      query.where((tbl) => tbl.createdAt.isSmallerOrEqualValue(endDate));
    }
    if (apiaries != null && hives != null) {
      query.where((tbl) => tbl.apiaryId.isIn(apiaries.map((e) => e.id)) | tbl.hiveId.isIn(hives.map((e) => e.id)));
    } else {
      if (apiaries != null) {
        query.where((tbl) => tbl.apiaryId.isIn(apiaries.map((e) => e.id)));
      }
      if (hives != null) {
        query.where((tbl) => tbl.hiveId.isIn(hives.map((e) => e.id)));
      }
    }
    return query.get();
  }

}

extension on Raport {
  RaportTableCompanion toCompanion() {
    return RaportTableCompanion(
      id: Value(id),
      hiveId: Value(hiveId),
      apiaryId: Value(apiaryId),
      createdAt: Value(createdAt),
      raportType: Value(raportType),
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
