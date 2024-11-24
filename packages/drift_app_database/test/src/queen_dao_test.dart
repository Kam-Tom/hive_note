import 'package:app_database/app_database.dart';
import 'package:drift_app_database/drift_app_database.dart';
import 'package:drift/native.dart';
import 'package:test/test.dart';

void main() {
  group('Queen Dao Tests', () {
    late DriftAppDatabase appDatabase;

    setUp(() {
      appDatabase = DriftAppDatabase.forTesting(NativeDatabase.memory());
    });

    tearDown(() async {
      await appDatabase.close();
    });

    test('stream emits updated list of queens when new queen is added',
        () async {
      final queen1 = Queen(
          breed: 'breed1',
          birthDate: DateTime.now(),
          origin: 'origin1',
          isAlive: true);

      final queen2 = Queen(
          breed: 'breed2',
          birthDate: DateTime.now().add(Duration(days: 1)),
          origin: 'origin2',
          isAlive: true);

      final expectation = expectLater(
        appDatabase.watchQueensWithHiveByApiary(null),
        emitsInOrder([
          [QueenWithHive(queen: queen1)],
          [
            QueenWithHive(queen: queen1),
            QueenWithHive(queen: queen2),
          ]
        ]),
      );

      await appDatabase.insertQueen(queen1);
      await appDatabase.insertQueen(queen2);

      await expectation;
    });
    test(
        'stream emits updated list of queens when queens birthDate have changed',
        () async {
      final queen1 = Queen(
          breed: 'breed1',
          birthDate: DateTime.now(),
          origin: 'origin1',
          isAlive: true);

      final queen2 = Queen(
          breed: 'breed2',
          birthDate: DateTime.now().add(Duration(days: 1)),
          origin: 'origin2',
          isAlive: true);

      final updatedQueen1 =
          queen1.copyWith(birthDate: DateTime.now().add(Duration(days: 2)));

      final expectation = expectLater(
        appDatabase.watchQueensWithHiveByApiary(null),
        // We can't use emitsInOrder because [queen1, queen2] can be omitted when operations are done in the same transaction
        emitsThrough([
          QueenWithHive(queen: queen2),
          QueenWithHive(queen: updatedQueen1),
        ]),
      );

      await appDatabase.insertQueen(queen1);
      await appDatabase.insertQueen(queen2);
      await appDatabase.updateQueen(updatedQueen1);

      await expectation;
    });

    test('stream emits updated list of queens hive is assigned', () async {
      final queen = Queen(
          breed: 'breed',
          birthDate: DateTime.now(),
          origin: 'origin',
          isAlive: true);

      final hive = Hive(
          name: 'Hive 1',
          type: 'Langstroth',
          order: 1,
          createdAt: DateTime.now());

      final updatedQueen = queen.copyWith(hiveId: () => hive.id);

      final expectation = expectLater(
        appDatabase.watchQueensWithHiveByApiary(null),
        emitsThrough([QueenWithHive(queen: updatedQueen, hive: hive)]),
      );

      await appDatabase.insertQueen(queen);
      await appDatabase.insertHive(hive);
      await appDatabase.updateQueen(updatedQueen);

      await expectation;
    });
    test('stream emits list of queens from apiary', () async {
      final apiary = Apiary(
          id: '1', order: 1, name: 'Apiary 1', createdAt: DateTime.now());

      final queen1 = Queen(
          breed: 'breed1',
          birthDate: DateTime.now(),
          origin: 'origin1',
          isAlive: true,
          hiveId: '1');
      final queen2 = Queen(
          breed: 'breed2',
          birthDate: DateTime.now().add(Duration(days: 1)),
          origin: 'origin2',
          isAlive: true,
          hiveId: '2');
      final hive1 = Hive(
          id: '1',
          name: 'Hive 1',
          type: 'Langstroth',
          order: 1,
          createdAt: DateTime.now());
      final hive2 = Hive(
          id: '2',
          name: 'Hive 2',
          apiaryId: '1',
          type: 'Langstroth',
          order: 1,
          createdAt: DateTime.now());

      final expectation = expectLater(
        appDatabase.watchQueensWithHiveByApiary(apiary),
        emitsThrough(
          [QueenWithHive(queen: queen2, hive: hive2)],
        ),
      );

      await appDatabase.insertApiary(apiary);
      await appDatabase.insertHive(hive1);
      await appDatabase.insertHive(hive2);
      await appDatabase.insertQueen(queen1);
      await appDatabase.insertQueen(queen2);

      await expectation;
    });
  });
}
