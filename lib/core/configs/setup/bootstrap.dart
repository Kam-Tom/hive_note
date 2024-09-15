import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_note/dashboard/presentation/dashboard_page.dart';
import 'package:hive_note/edit_apiary/presentation/edit_apiary_page.dart';
import 'package:hive_note/manage_apiaries/presentation/manage_apiaries_page.dart';
import 'package:logger/logger.dart';
import 'setup.dart';

void bootstrap() {
  Logger logger = Logger();

  FlutterError.onError = (details) {
    logger.e(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver(logger: logger);

  // Create and provide all necessary repositories to App
  final repositoryProvidersSetup = MultiRepositoryProviderSetup();

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await EasyLocalization.ensureInitialized();

      runApp(
        EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('pl')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: repositoryProvidersSetup
              .wrapWithRepositories(child: const MyApp()),
        ),
      );
    },
    (error, stackTrace) => logger.e(error.toString(), stackTrace: stackTrace),
  );
}

