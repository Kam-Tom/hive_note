import 'package:flutter/material.dart';
import 'package:hive_note/dashboard/presentation/dashboard_page.dart';
import 'package:hive_note/edit_apiary/presentation/edit_apiary_page.dart';
import 'package:hive_note/edit_hive/presentation/edit_hive_page.dart';
import 'package:hive_note/edit_queen/presentation/edit_queen_page.dart';
import 'package:hive_note/manage_apiaries/presentation/manage_apiaries_page.dart';
import 'package:hive_note/manage_hives/presentation/manage_hives_page.dart';
import 'package:hive_note/manage_queens/presentation/manage_queens_page.dart';
import 'package:hive_note/manage_todos/presentation/manage_todos_page.dart';
import 'package:hive_note/navigation/presentation/pages/records.dart';
import 'package:hive_note/shared/presentation/pages/tmp_page.dart';

class AppRouter {
  static const String emptyPath = '/';
  static const String dashboardPath = '/dashboard';
  static const String manageApiariesPath = '/manage_apiaries';
  static const String manageQueensPath = '/manage_queens';
  static const String manageHivesPath = '/manage_hives';
  static const String tmpPath = '/tmp';
  static const String manageTodosPath = '/manage_todos_path';
  static const String recordsPath = '/records';
  static const String editApiaryPath = '/edit_apiary';
  static const String editHivePath = '/edit_hive';
  static const String editQueenPath = '/edit_queen';


  static Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouter.emptyPath :
        return MaterialPageRoute(
          builder:  (_) => const DashboardPage()
        );
      case AppRouter.tmpPath :
        return MaterialPageRoute(
          builder:  (_) => const TMPPage()
        );         
      case AppRouter.manageTodosPath:
        return MaterialPageRoute(
          builder:  (_) => const ManageTodosPage()
        );      
      case AppRouter.recordsPath :
        return MaterialPageRoute(
          builder:  (_) => const RecordsPage()
        );
      case AppRouter.dashboardPath :
        return MaterialPageRoute(
          builder:  (_) => const ManageApiariesPage()
        );
      case AppRouter.manageApiariesPath:
        return MaterialPageRoute(
          builder: (_) => const ManageApiariesPage()
        );      
      case AppRouter.editApiaryPath:
        return MaterialPageRoute(
          builder: (_) => EditApiaryPage(apiaryId: settings.arguments as String)
        );      
      case AppRouter.manageHivesPath:
        return MaterialPageRoute(
          builder: (_) => const ManageHivesPage()
        );     
      case AppRouter.editHivePath:
        return MaterialPageRoute(
          builder: (_) => EditHivePage(hiveId: settings.arguments as String)
        );      
      case AppRouter.manageQueensPath:
        return MaterialPageRoute(
          builder: (_) => const ManageQueensPage()
        );     
      case AppRouter.editQueenPath:
        return MaterialPageRoute(
          builder: (_) => EditQueenPage(queenId: settings.arguments as String)
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const DashboardPage()
        );
    }
  }
}
