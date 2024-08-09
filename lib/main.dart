import 'package:flutter/material.dart';
import 'package:hive_note/core/configs/theme/app_theme.dart';
import 'package:hive_note/navigation/presentation/pages/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: DashboardPage()
    );
  }
}