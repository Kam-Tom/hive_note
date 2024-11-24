import 'package:app_database/app_database.dart';
import 'package:drift_app_database/drift_app_database.dart';
import 'package:drift/native.dart';
import 'package:test/test.dart';

void main() {
  group('Apiary Dao Tests', () {
    late DriftAppDatabase appDatabase;

    setUp(() {
      appDatabase = DriftAppDatabase.forTesting(NativeDatabase.memory());
    });

    tearDown(() async {
      await appDatabase.close();
    });

    test('stream emits updated list of apiaries when new apiary is added',
        () async {
      final apiary1 = Apiary(
          id: '1', order: 1, name: 'Apiary 1', createdAt: DateTime.now());
      final apiary2 = Apiary(
          id: '2', order: 2, name: 'Apiary 2', createdAt: DateTime.now());

      final expectation = expectLater(
        appDatabase.watchApiariesWithHiveCount(false),
        emitsInOrder([
          [ApiaryWithHiveCount(apiary: apiary1, hiveCount: 0)],
          [
            ApiaryWithHiveCount(apiary: apiary1, hiveCount: 0),
            ApiaryWithHiveCount(apiary: apiary2, hiveCount: 0)
          ]
        ]),
      );

      await appDatabase.insertApiary(apiary1);
      await appDatabase.insertApiary(apiary2);

      await expectation;
    });
    test(
        'stream emits updated list of apiaries when apiaries order have changed',
        () async {
      final apiary1 = Apiary(
          id: '1', order: 1, name: 'Apiary 1', createdAt: DateTime.now());
      final apiary2 = Apiary(
          id: '2', order: 2, name: 'Apiary 2', createdAt: DateTime.now());

      final updatedApiary1 = apiary1.copyWith(order: 3);

      final expectation = expectLater(
        appDatabase.watchApiariesWithHiveCount(false),
        // We can't use emitsInOrder because [apiary1, apiary2] can be omitted when operations are done in the same transaction
        emitsThrough([
          ApiaryWithHiveCount(apiary: apiary2, hiveCount: 0),
          ApiaryWithHiveCount(apiary: updatedApiary1, hiveCount: 0)
        ]),
      );

      await appDatabase.insertApiary(apiary1);
      await appDatabase.insertApiary(apiary2);
      await appDatabase.updateApiary(updatedApiary1);

      await expectation;
    });

    test('stream emits updated list of apiaries when new hive is added',
        () async {
      final apiary = Apiary(
          id: '1', name: 'Apiary 1', order: 0, createdAt: DateTime.now());
      final hive = Hive(
          id: '1',
          name: 'Hive 1',
          apiaryId: '1',
          type: 'Langstroth',
          order: 1,
          createdAt: DateTime.now());

      final expectation = expectLater(
        appDatabase.watchApiariesWithHiveCount(false),
        emitsInOrder([
          [ApiaryWithHiveCount(apiary: apiary, hiveCount: 0)],
          [ApiaryWithHiveCount(apiary: apiary, hiveCount: 1)]
        ]),
      );

      await appDatabase.insertApiary(apiary);
      await appDatabase.insertHive(hive);

      await expectation;
    });
    test('stream emits updated list of apiaries when hive is updated',
        () async {
      final apiary = Apiary(
          id: '1', order: 1, name: 'Apiary 1', createdAt: DateTime.now());
      final apiary2 = Apiary(
          id: '2', order: 2, name: 'Apiary 2', createdAt: DateTime.now());
      final hive = Hive(
          id: '1',
          name: 'Hive 1',
          apiaryId: '1',
          type: 'Langstroth',
          order: 1,
          createdAt: DateTime.now());
      final updatedHive = Hive(
          id: '1',
          name: 'Hive 1',
          apiaryId: '2',
          type: 'Langstroth',
          order: 1,
          createdAt: DateTime.now());

      final stream = appDatabase.watchApiariesWithHiveCount(false);

      // We can't use one expectLater because some operations can be omitted when operations are done in the same transaction
      // act & assert for every operation
      await appDatabase.insertApiary(apiary);
      await expectLater(
        stream,
        emitsInOrder([
          [ApiaryWithHiveCount(apiary: apiary, hiveCount: 0)]
        ]),
      );

      await appDatabase.insertApiary(apiary2);
      await expectLater(
        stream,
        emitsInOrder([
          [
            ApiaryWithHiveCount(apiary: apiary, hiveCount: 0),
            ApiaryWithHiveCount(apiary: apiary2, hiveCount: 0)
          ]
        ]),
      );

      await appDatabase.insertHive(hive);
      await expectLater(
        stream,
        emitsInOrder([
          [
            ApiaryWithHiveCount(apiary: apiary, hiveCount: 1),
            ApiaryWithHiveCount(apiary: apiary2, hiveCount: 0)
          ]
        ]),
      );

      await appDatabase.updateHive(updatedHive);
      await expectLater(
        stream,
        emitsInOrder([
          [
            ApiaryWithHiveCount(apiary: apiary, hiveCount: 0),
            ApiaryWithHiveCount(apiary: apiary2, hiveCount: 1)
          ]
        ]),
      );
    });
  });
}
