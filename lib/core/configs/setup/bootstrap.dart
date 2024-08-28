import 'dart:async';

import 'package:drift_app_database/drift_app_database.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:repositories/repositories.dart';

import 'setup.dart';

void bootstrap() {
  Logger logger = Logger();
  
  FlutterError.onError = (details) {
    logger.e(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver(logger: logger);

  final DriftAppDatabase database = DriftAppDatabase();

  final todoRepository = TodoRepository(database);
  
  runZonedGuarded(
    () async {

      WidgetsFlutterBinding.ensureInitialized();
      await EasyLocalization.ensureInitialized();

      runApp(EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('pl')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: MyApp(todoRepository: todoRepository),
      ));
    },
    (error, stackTrace) => logger.e(error.toString(), stackTrace: stackTrace),
  );
}
