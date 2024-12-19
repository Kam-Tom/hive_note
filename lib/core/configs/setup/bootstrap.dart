import 'dart:async';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'setup.dart';
import 'flutter_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

void bootstrap() {
  const bool isProduction = bool.fromEnvironment('dart.vm.product');

  Logger logger = Logger(
    filter: isProduction ? ProductionFilter() : DevelopmentFilter(),
  );

  FlutterError.onError = (details) {
    logger.e(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver(logger: logger);

  // Set the existing logger in NotificationService
  NotificationService.setLogger(logger);

  // Create and provide all necessary repositories to App
  final repositoryProvidersSetup = MultiRepositoryProviderSetup();

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      
      // Lock orientation to portrait only
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      tz.initializeTimeZones();
      
      // Initialize repositories
      await repositoryProvidersSetup.initialize();
      
      await NotificationService.init();
      await EasyLocalization.ensureInitialized();

      // Get system locale using PlatformDispatcher instead of window
      final deviceLocale = PlatformDispatcher.instance.locale;
      
      runApp(
        EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('pl')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: repositoryProvidersSetup
              .wrapWithRepositories(child: MyApp(initialLocale: deviceLocale)),
        ),
      );
    },
    (error, stackTrace) => logger.e(error.toString(), stackTrace: stackTrace),
  );
}

