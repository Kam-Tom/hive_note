import 'package:app_database/app_database.dart';
import 'package:drift_app_database/drift_app_database.dart';
import 'package:drift/native.dart';
import 'package:test/test.dart';

void main() {
  group('Todo Dao Tests', () {
    late DriftAppDatabase appDatabase;

    setUp(() {
      appDatabase = DriftAppDatabase.forTesting(NativeDatabase.memory());
    });

    tearDown(() async {
      await appDatabase.close();
    });

    test('stream emits updated list of todos when new todo is added', () async {
      final todo1 = Todo(id: '1', location: 'Loc 1', description: 'Desc...', dueTo: DateTime.now(), isCompleted: false, categoryType: CategoryType.buy);
      final todo2 = Todo(id: '2', location: 'Loc 1', description: 'Desc...', dueTo: DateTime.now(), isCompleted: false, categoryType: CategoryType.buy);

      final expectation = expectLater(
        appDatabase.watchTodos(),
        emitsInOrder([[todo1],[todo1,todo2]]),
      );

      await appDatabase.insertTodo(todo1);
      await appDatabase.insertTodo(todo2);

      await expectation;

    });

    test('stream emits updated list of todos when todo is updated', () async {
      final todo = Todo(id: '1', location: 'Loc 1', description: 'Desc...', dueTo: DateTime.now(), isCompleted: false, categoryType: CategoryType.buy);
      final updatedTodo = Todo(id: '1', location: 'Loc 2', description: 'Desc...', dueTo: DateTime.now(), isCompleted: false, categoryType: CategoryType.buy);
      
      final expectation = expectLater(
        appDatabase.watchTodos(),
        emitsInOrder([
          [todo],
          [updatedTodo]]),
      );

      await appDatabase.insertTodo(todo);
      await appDatabase.updateTodo(updatedTodo);

      await expectation;

    });
    test('stream emits updated list of todos when todo is deleted', () async {
      final todo = Todo(id: '1', location: 'Loc 1', description: 'Desc...', dueTo: DateTime.now(), isCompleted: false, categoryType: CategoryType.buy);
      
      final expectation = expectLater(
        appDatabase.watchTodos(),
        emitsInOrder([
          [todo],
          []]),
      );

      await appDatabase.insertTodo(todo);
      await appDatabase.removeTodo(todo);

      await expectation;

    });
    test('should throw error when insert todo with same id', () async {
      final todo = Todo(id: '1', location: 'Loc 1', description: 'Desc...', dueTo: DateTime.now(), isCompleted: false, categoryType: CategoryType.buy);
      final todo2 = Todo(id: '1', location: 'Loc 1', description: 'Desc...', dueTo: DateTime.now(), isCompleted: false, categoryType: CategoryType.buy);

      await appDatabase.insertTodo(todo);

      expect(() async => await appDatabase.insertTodo(todo2), throwsA(isA<SqliteException>()));

    });

  });
}
