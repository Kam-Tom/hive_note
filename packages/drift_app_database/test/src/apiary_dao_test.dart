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

    test('stream emits updated list of apiaries when new apiary is added', () async {
      final apiary1 = Apiary(id: '1', name: 'Apiary 1', createdAt: DateTime.now());
      final apiary2 = Apiary(id: '2', name: 'Apiary 2', createdAt: DateTime.now());

      final expectation = expectLater(
        appDatabase.watchApiaries(),
        emitsInOrder([[apiary1],[apiary1,apiary2]]),
      );

      await appDatabase.insertApiary(apiary1);
      await appDatabase.insertApiary(apiary2);

      await expectation;

    });
    test('stream emits updated list of apiaries when new hive is added', () async {
      final apiary = Apiary(id: '1', name: 'Apiary 1', createdAt: DateTime.now());
      final hive = Hive(id: '1', name: 'Hive 1', apiaryId: '1', type:'Langstroth', order: 1, createdAt: DateTime.now());

      final expectation = expectLater(
        appDatabase.watchApiaries(),
        emitsInOrder([
          [apiary],
          [apiary.copyWith(hives: [hive])]]),
      );

      await appDatabase.insertApiary(apiary);
      await appDatabase.insertHive(hive);

      await expectation;

    });
    test('stream emits updated list of apiaries when hive is updated', () async {
      final apiary = Apiary(id: '1', name: 'Apiary 1', createdAt: DateTime.now());
      final apiary2 = Apiary(id: '2', name: 'Apiary 1', createdAt: DateTime.now());
      final hive = Hive(id: '1', name: 'Hive 1', apiaryId: '1', type:'Langstroth', order: 1, createdAt: DateTime.now());
      final updatedhive = Hive(id: '1', name: 'Hive 1', apiaryId: '2', type:'Langstroth', order: 1, createdAt: DateTime.now());

      final expectation = expectLater(
        appDatabase.watchApiaries(),
        emitsInOrder([
          [apiary],
          [apiary,apiary2],
          [apiary.copyWith(hives: [hive]),apiary2],
          [apiary,apiary2.copyWith(hives: [hive])]]),
      );

      await appDatabase.insertApiary(apiary);
      await appDatabase.insertApiary(apiary2);
      await appDatabase.insertHive(hive);
      await appDatabase.updateHive(updatedhive);

      await expectation;

    });
  });
}
