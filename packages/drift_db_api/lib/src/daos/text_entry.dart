import 'package:db_api/db_api.dart';
import 'package:drift/drift.dart';
import 'package:drift_db_api/drift_db_api.dart';
import 'package:drift_db_api/src/tabels/tabels.dart';

part 'text_entry.g.dart';

// the ApiaryDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <DriftDbApi> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [TextEntryTable])
class TextEntryDao extends DatabaseAccessor<DriftDbApi> with _$TextEntryDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  TextEntryDao(DriftDbApi db) : super(db);
  

}