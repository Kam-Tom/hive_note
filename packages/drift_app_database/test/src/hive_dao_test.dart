import 'package:app_database/app_database.dart';
import 'package:drift_app_database/drift_app_database.dart';
import 'package:drift/native.dart';
import 'package:test/test.dart';

void main() {
  group('HiveDao', () {
    late DriftAppDatabase appDatabase;

    setUp(() {
      appDatabase = DriftAppDatabase.forTesting(
        NativeDatabase.memory(),
      );
    });

    tearDown(() async {
      await appDatabase.close();
    });

    test(
      '''should successfully insert a new hive
            and retrieve it by id''',
      () async {
        final hive = Hive(
          id: '1',
          name: 'Test Hive',
          order: 1,
          type: 'Langstroth',
          apiaryId: null,
          createdAt: DateTime.now(),
        );

        await appDatabase.hiveDao.insertHive(hive);
        final result = await appDatabase
            .hiveDao
            .getHive(hive.id);
        expect(result.id, equals(hive.id));
        expect(result.name, equals(hive.name));
      },
    );

    // ... other tests
  });
}

//     test('should update existing hive properties and persist changes', () async {
//       final hive = Hive(
//         id: '1',
//         name: 'Test Hive',
//         order: 1,
//         type: 'Langstroth',
//         apiaryId: null,
//         createdAt: DateTime.now(),
//       );

//       await appDatabase.hiveDao.insertHive(hive);
      
//       final updatedHive = hive.copyWith(name: 'Updated Hive');
//       await appDatabase.hiveDao.updateHive(updatedHive);
      
//       final result = await appDatabase.hiveDao.getHive(hive.id);
//       expect(result.name, equals('Updated Hive'));
//     });

//     test('should delete hive and throw StateError when trying to fetch deleted hive', () async {
//       final hive = Hive(
//         id: '1',
//         name: 'Test Hive',
//         order: 1,
//         type: 'Langstroth',
//         apiaryId: null,
//         createdAt: DateTime.now(),
//       );

//       await appDatabase.hiveDao.insertHive(hive);
//       await appDatabase.hiveDao.deleteHive(hive);
      
//       expect(
//         () async => await appDatabase.hiveDao.getHive(hive.id),
//         throwsStateError,
//       );
//     });

//     test('should emit updated HiveWithQueen when queen is assigned to hive', () async {
//       final hive = Hive(
//         id: '1',
//         name: 'Test Hive',
//         order: 1,
//         type: 'Langstroth',
//         apiaryId: null,
//         createdAt: DateTime.now(),
//       );

//       final queen = Queen(
//         id: '1',
//         hiveId: '1',
//         breed: "Italian",
//         origin: "Unknown",
//         isAlive: true,
//         birthDate: DateTime.now(),
//       );

//       await appDatabase.hiveDao.insertHive(hive);
//       await appDatabase.queenDao.insertQueen(queen);

//       final stream = appDatabase.hiveDao.watchHiveWithQueen(hive.id);
      
//       expect(
//         stream,
//         emits(predicate<HiveWithQueen>((hiveWithQueen) =>
//           hiveWithQueen.hive.id == hive.id &&
//           hiveWithQueen.queen?.id == queen.id)),
//       );
//     });

//     test('should return all hives belonging to specific apiary in correct order', () async {
//       final apiary = Apiary(
//         id: '1',
//         order: 1,
//         name: 'Test Apiary',
//         createdAt: DateTime.now(),
//       );
      
//       final hive1 = Hive(
//         id: '1',
//         name: 'Hive 1',
//         order: 1,
//         type: 'Langstroth',
//         apiaryId: apiary.id,
//         createdAt: DateTime.now(),
//       );

//       final hive2 = Hive(
//         id: '2',
//         name: 'Hive 2',
//         order: 2,
//         type: 'Langstroth',
//         apiaryId: apiary.id,
//         createdAt: DateTime.now(),
//       );

//       await appDatabase.apiaryDao.insertApiary(apiary);
//       await appDatabase.hiveDao.insertHive(hive1);
//       await appDatabase.hiveDao.insertHive(hive2);

//       final hives = await appDatabase.hiveDao.getHivesByApiary(apiary);
//       expect(hives.length, equals(2));
//       expect(hives.map((h) => h.id), containsAll([hive1.id, hive2.id]));
//     });

//     test('should return empty list when querying hives for non-existent apiary', () async {
//       final nonExistentApiary = Apiary(
//         id: 'non-existent',
//         order: 1,
//         name: 'Non-existent Apiary',
//         createdAt: DateTime.now(),
//       );

//       final hives = await appDatabase.hiveDao.getHivesByApiary(nonExistentApiary);
//       expect(hives, isEmpty);
//     });

//     test('should return hives without apiary when querying with null apiary', () async {
//       final hive = Hive(
//         id: '1',
//         name: 'Orphan Hive',
//         order: 1,
//         type: 'Langstroth',
//         apiaryId: null,
//         createdAt: DateTime.now(),
//       );

//       await appDatabase.hiveDao.insertHive(hive);
//       final orphanHives = await appDatabase.hiveDao.getHivesByApiary(null);
      
//       expect(orphanHives.length, equals(1));
//       expect(orphanHives.first.apiaryId, isNull);
//     });

//     test('should maintain correct order when watching hives with queens in apiary', () async {
//       // Setup test data
//       final apiary = Apiary(
//         id: '1',
//         order: 1,
//         name: 'Test Apiary',
//         createdAt: DateTime.now(),
//       );
      
//       final hives = List.generate(3, (index) => Hive(
//         id: 'hive_$index',
//         name: 'Hive $index',
//         order: index,
//         type: 'Langstroth',
//         apiaryId: apiary.id,
//         createdAt: DateTime.now(),
//       ));

//       await appDatabase.apiaryDao.insertApiary(apiary);
//       for (final hive in hives) {
//         await appDatabase.hiveDao.insertHive(hive);
//       }

//       final stream = appDatabase.hiveDao.watchHivesWithQueenByApiary(apiary);
      
//       expect(
//         stream,
//         emits(predicate<List<HiveWithQueen>>((hivesWithQueens) =>
//           hivesWithQueens.length == 3 &&
//           hivesWithQueens.map((h) => h.hive.order).toList().toString() == '[0, 1, 2]')),
//       );
//     });
//   });
// }
