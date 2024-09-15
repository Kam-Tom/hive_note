import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_note/core/configs/setup/app_router.dart';
import 'package:hive_note/core/configs/theme/app_theme.dart';
import 'package:hive_note/dashboard/presentation/dashboard_page.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppTheme.lightTheme,
      onGenerateRoute: AppRouter.onGeneratedRoute,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      home: const DashboardPage()
    );
  }
}

