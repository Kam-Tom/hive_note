import 'package:db_api/db_api.dart';
import 'package:drift/drift.dart';
import 'package:drift_db_api/drift_db_api.dart';
import 'package:drift_db_api/src/tabels/tabels.dart';

part 'queen.g.dart';

// the ApiaryDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <DriftDbApi> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [QueenTable])
class QueenDao extends DatabaseAccessor<DriftDbApi> with _$QueenDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  QueenDao(DriftDbApi db) : super(db);
  

}