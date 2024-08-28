import 'package:app_database/app_database.dart';
import 'package:drift_app_database/drift_app_database.dart';
import 'package:drift/native.dart';
import 'package:test/test.dart';

void main() {
  group('Hive Dao Tests', () {
    late DriftAppDatabase appDatabase;

    setUp(() {
      appDatabase = DriftAppDatabase.forTesting(NativeDatabase.memory());
    });

    tearDown(() async {
      await appDatabase.close();
    });

  });
}
