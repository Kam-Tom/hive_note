import 'package:db_api/db_api.dart';
import 'package:drift/native.dart';
import 'package:drift_db_api/drift_db_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Drift Database Tests', () {
    late DriftDbApi appDatabase;

    setUp(() {
      appDatabase = DriftDbApi.forTesting(NativeDatabase.memory());
    });

    tearDown(() async {
      await appDatabase.close();
    });

    // test('should retrieve an apiary by id', () async {
    //   // Arrange
    //   final apiary = Apiary(
    //     name: 'Test Apiary',
    //     latitude: 10.0,
    //     longitude: 20.0,
    //     createdAt: DateTime.now(),
    //   );

    //   // Act
    //   await appDatabase.insertApiary(apiary);
    //   final fetchedApiary = await appDatabase.getApiary(apiary.id);

    //   // Assert
    //   expect(fetchedApiary, apiary);
    // });
  });
}
