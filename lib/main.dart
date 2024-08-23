import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'core/configs/theme/app_theme.dart';
import 'navigation/presentation/pages/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('pl')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: DashboardPage()
    );
  }
}