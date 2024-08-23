import 'package:db_api/db_api.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tabels/tabels.dart';
part 'drift_db_api.g.dart';

/// {@template drift_db_api}
/// A Flutter implementation of the DBApi that uses SQLite with Drift ORM.
/// {@endtemplate}

@DriftDatabase(
  tables: [
    ApiaryTable,
    QueenTable,
    HiveTable,
    RaportTable,
    EntryMetadataTable,
    BooleanEntryTable,
    TextEntryTable,
    NumericEntryTable,
    HistoryLogTable,
  ]
)
class DriftDbApi extends _$DriftDbApi  {
  /// {@macro drift_db_api}
  DriftDbApi() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Named constructor for creating in-memory database
  DriftDbApi.forTesting(super.e);

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'hive_note_database');
  }

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
        });


  Future<Apiary> getApiary(String id) {
    return (select(apiaryTable)..where((tbl) => tbl.id.equals(id))).getSingle();
  }
  Future<void> insertApiary(Apiary apiary) => into(apiaryTable).insert(ApiaryTableCompanion(
    id: Value(apiary.id),
    name: Value(apiary.name),
    createdAt: Value(apiary.createdAt),
    latitude: Value(apiary.latitude),
    longitude: Value(apiary.longitude),
    ));
}
