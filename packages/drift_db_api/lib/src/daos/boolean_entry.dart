import 'package:db_api/db_api.dart';
import 'package:drift/drift.dart';
import 'package:drift_db_api/drift_db_api.dart';
import 'package:drift_db_api/src/tabels/tabels.dart';

part 'boolean_entry.g.dart';

@DriftAccessor(tables: [BooleanEntryTable, RaportTable, EntryMetadataTable])
class BooleanEntryDao extends DatabaseAccessor<DriftDbApi> with _$BooleanEntryDaoMixin {

  BooleanEntryDao(DriftDbApi db) : super(db);

}