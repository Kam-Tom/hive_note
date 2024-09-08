import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/core/configs/theme/app_theme.dart';
import 'package:hive_note/dashboard/presentation/dashboard_page.dart';
import 'package:repositories/repositories.dart';

class MyApp extends StatelessWidget {
  final TodoRepository todoRepository;
  final ApiaryRepository apiaryRepository;
  const MyApp({
    super.key, 
    required this.todoRepository,
    required this.apiaryRepository
    });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: MultiRepositoryProvider(providers: [
        RepositoryProvider(create: (context) => todoRepository),
        RepositoryProvider(create: (context) => apiaryRepository),
      ], 
      child: const DashboardPage())
    );
  }
}
