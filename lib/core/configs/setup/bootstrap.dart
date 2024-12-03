import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'setup.dart';
import 'flutter_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

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
      tz.initializeTimeZones();
      await NotificationService.init();
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

