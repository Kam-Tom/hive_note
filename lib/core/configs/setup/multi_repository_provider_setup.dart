import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';
import 'package:drift_app_database/drift_app_database.dart';

class MultiRepositoryProviderSetup {
  final AppDatabase database = DriftAppDatabase();

  MultiRepositoryProvider wrapWithRepositories({required Widget child}) {
    final todoRepository = TodoRepository(database);
    final apiaryRepository = ApiaryRepository(database);
    final hiveRepository = HiveRepository(database);
    final queenRepository = QueenRepository(database);
    final preferencesRepository = PreferencesRepository();
    final entryMetadataRepository = EntryMetadataRepository(database);
    final raportRepository = RaportRepository(database);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TodoRepository>(
          create: (context) => todoRepository,
        ),
        RepositoryProvider<ApiaryRepository>(
          create: (context) => apiaryRepository,
        ),        
        RepositoryProvider<HiveRepository>(
          create: (context) => hiveRepository,
        ),        
        RepositoryProvider<QueenRepository>(
          create: (context) => queenRepository,
        ),
        RepositoryProvider<PreferencesRepository>(
          create: (context) => preferencesRepository,
        ),
        RepositoryProvider<EntryMetadataRepository>(
          create: (context) => entryMetadataRepository,
        ),
      ],
      child: child,
    );
  }
}