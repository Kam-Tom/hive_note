import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/settings/preferences/bloc/preferences_bloc.dart';
import 'package:hive_note/core/configs/setup/app_router.dart';
import 'package:hive_note/core/configs/theme/app_theme.dart';
import 'package:hive_note/dashboard/presentation/dashboard_page.dart';
import 'package:repositories/repositories.dart';

class MyApp extends StatelessWidget {
  final Locale initialLocale;
  
  const MyApp({
    super.key,
    required this.initialLocale,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PreferencesBloc(
        preferencesRepository: context.read<PreferencesRepository>(),
      )..add(LoadPreferences(initialLocale)),
      child: BlocListener<PreferencesBloc, PreferencesState>(
        listenWhen: (previous, current) => previous.language != current.language,
        listener: (context, state) {
          if (state.language.isNotEmpty) {
            context.setLocale(Locale(state.language));
          }
        },
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: AppTheme.lightTheme,
          onGenerateRoute: AppRouter.onGeneratedRoute,
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
          home: const DashboardPage()
        ),
      ),
    );
  }
}

