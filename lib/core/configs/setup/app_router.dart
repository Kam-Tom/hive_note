import 'package:flutter/material.dart';
import 'package:hive_note/dashboard/presentation/dashboard_page.dart';
import 'package:hive_note/edit_apiary/presentation/edit_apiary_page.dart';
import 'package:hive_note/manage_apiaries/presentation/manage_apiaries_page.dart';
import 'package:hive_note/shared/presentation/pages/tmp_page.dart';

class AppRouter {
  static const String emptyPath = '/';
  static const String dashboardPath = '/dashboard';
  static const String manageApiariesPath = '/manage_apiaries';
  static const String manageHivesPath = '/manage_queens';
  static const String manageQueensPath = '/manage_hives';
  static const String tmpPath = '/tmp';
  static const String editApiaryPath = '/edit_apiary';


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
      case AppRouter.dashboardPath :
        return MaterialPageRoute(
          builder:  (_) => const ManageApiariesPage()
        );
      case AppRouter.manageApiariesPath:
        return MaterialPageRoute(
          builder: (_) => const ManageApiariesPage()
        );      
      case AppRouter.editApiaryPath:
      final apiaryId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => EditApiaryPage(apiaryId: apiaryId)
        );
      case AppRouter.manageHivesPath:
        return MaterialPageRoute(
          builder: (_) => const TMPPage()
        );     
      case AppRouter.manageQueensPath:
        return MaterialPageRoute(
          builder: (_) => const TMPPage()
        );     
      default:
        return MaterialPageRoute(
          builder: (_) => const DashboardPage()
        );
    }
  }
}
