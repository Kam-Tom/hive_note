import 'package:db_api/db_api.dart';
import 'package:drift/native.dart';
import 'package:drift_db_api/drift_db_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiaryDao Tests', () {
    late DriftDbApi appDatabase;

    setUp(() {
      appDatabase = DriftDbApi.forTesting(NativeDatabase.memory());
    });

    tearDown(() async {
      await appDatabase.close();
    });

    test('should retrieve an apiary by id', () async {
      // Arrange
      final apiary = Apiary(
        name: 'Test Apiary',
        latitude: 10.0,
        longitude: 20.0,
        createdAt: DateTime.now(),
      );

      // Act
      await appDatabase.insertApiary(apiary);
      final fetchedApiary = await appDatabase.getApiary(apiary.id);

      // Assert
      expect(fetchedApiary, apiary);
    });
    test('should throw an error when inserting an apiary with an existing id', () async {
      // Arrange
      final apiary = Apiary(
        name: 'Test Apiary',
        latitude: 10.0,
        longitude: 20.0,
        createdAt: DateTime.now(),
      );

      // Act
      await appDatabase.insertApiary(apiary);

      //Assert
      expect(appDatabase.insertApiary(apiary),
      throwsA(isA<ResourceAlreadyExistsException>()));

    });
    test('should throw error when apiary with id does not exist', () async {
      // Arrange
      final apiary = Apiary(
        name: 'Test Apiary',
        latitude: 10.0,
        longitude: 20.0,
        createdAt: DateTime.now(),
      );

      // Act & Assert
      expect(
        () async => await appDatabase.getApiary(apiary.id),
        throwsA(isA<ResourceNotFoundException>()),
      );
    });
    test('should fetch all apiaries successfully', () async {
      // Arrange
      final apiary1 = Apiary(
        name: 'Apiary 1',
        latitude: 10.0,
        longitude: 20.0,
        createdAt: DateTime.now(),
      );
      final apiary2 = Apiary(
        name: 'Apiary 2',
        latitude: 30.0,
        longitude: 40.0,
        createdAt: DateTime.now(),
      );
      
      appDatabase.insertApiary(apiary1);
      appDatabase.insertApiary(apiary2);

      // Act
      final apiaries = await appDatabase.getApiaries();

      // Assert
      expect(apiaries.length, 2);
      expect(apiaries, [apiary1,apiary2]);
    });

    test('should delete apriary', () async {
      // Arrange
      final apiary = Apiary(
        name: 'Apiary 1',
        latitude: 10.0,
        longitude: 20.0,
        createdAt: DateTime.now(),
      );
      
      appDatabase.insertApiary(apiary);
      appDatabase.deleteApiary(apiary);

      // Act 
      final apiaries = await appDatabase.getApiaries();

      // Assert
      expect(apiaries.length, 0);
    });
    test('should not throw an error when deleting an apiary that does not exist', () async {
      // Arrange
      final apiary = Apiary(
        name: 'Apiary 1',
        latitude: 10.0,
        longitude: 20.0,
        createdAt: DateTime.now(),
      );

      //Act && Assert
      expect(appDatabase.deleteApiary(apiary),
        throwsA(isA<ResourceNotFoundException>()),
      );

    });
    test('should watch apiaries', () async {
      // Arrange
      final apiary1 = Apiary(
        name: 'Apiary 1',
        latitude: 10.0,
        longitude: 20.0,
        createdAt: DateTime.now(),
      );
      final apiary2 = Apiary(
        name: 'Apiary 2',
        latitude: 30.0,
        longitude: 40.0,
        createdAt: DateTime.now(),
      );

      final apiaryStream = appDatabase.watchApiaries();
      final apiaryList = <List<Apiary>>[];

      await appDatabase.insertApiary(apiary1);

      final subscription = apiaryStream.listen((apiaries) {
        apiaryList.add(apiaries);
      });

      // Act
      // Wait for the stream to emit value
      await Future.delayed(Duration(milliseconds: 100));

      await appDatabase.insertApiary(apiary2);
      await Future.delayed(Duration(milliseconds: 100));

      await appDatabase.deleteApiary(apiary1);
      await Future.delayed(Duration(milliseconds: 100));

      // Assert
      expect(apiaryList.length, 3);
      expect(apiaryList[0], [apiary1]);
      expect(apiaryList[1], [apiary1, apiary2]);
      expect(apiaryList[2], [apiary2]);

      // Clean up
      await subscription.cancel();
    });

    test('should update an existing apiary', () async {
    // Arrange
      final apiary = Apiary(
        name: 'Test Apiary',
        latitude: 10.0,
        longitude: 20.0,
        createdAt: DateTime.now(),
      );

      appDatabase.insertApiary(apiary);

      final updatedApiary = apiary.copyWith(name: 'Updated Apiary');

      // Act
      await appDatabase.updateApiary(updatedApiary);
      final fetchedApiary = await appDatabase.getApiary(apiary.id);

      // Assert
      expect(fetchedApiary, updatedApiary);
    });

    test('should throw an error when updating a non-existing apiary', () async {
      // Arrange
      final updatedApiary = Apiary(
        name: 'Test Apiary',
        latitude: 10.0,
        longitude: 20.0,
        createdAt: DateTime.now(),
      );

      // Act && Assert
      expect(
        appDatabase.updateApiary(updatedApiary),
        throwsA(isA<ResourceNotFoundException>()),
      );

    });

  });
}
