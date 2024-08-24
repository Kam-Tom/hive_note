import 'package:app_database/app_database.dart';

abstract class AppDatabase {
  Stream<List<ToDo>> watchTodos();
  
}
