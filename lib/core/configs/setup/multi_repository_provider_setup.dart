import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';
import 'package:drift_app_database/drift_app_database.dart';
import 'package:sp_user_pref/sp_user_pref.dart';

class MultiRepositoryProviderSetup {
  final AppDatabase database = DriftAppDatabase();
  late final SpUserPref spUserPref;

  Future<void> initialize() async {
    spUserPref = await SpUserPref.create();
  }

  MultiRepositoryProvider wrapWithRepositories({required Widget child}) {
    final todoRepository = TodoRepository(database);
    final apiaryRepository = ApiaryRepository(database);
    final hiveRepository = HiveRepository(database);
    final queenRepository = QueenRepository(database);
    final preferencesRepository = PreferencesRepository(spUserPref);
    final entryMetadataRepository = EntryMetadataRepository(database);
    final raportRepository = RaportRepository(database);
    final historyLogRepository = HistoryLogRepository(database);

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
        RepositoryProvider<RaportRepository>(
          create: (context) => raportRepository,
        ),        
        RepositoryProvider<HistoryLogRepository>(
          create: (context) => historyLogRepository,
        ),
      ],
      child: child,
    );
  }
}