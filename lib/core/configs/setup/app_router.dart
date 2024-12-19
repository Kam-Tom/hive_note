import 'package:flutter/material.dart';
import 'package:hive_note/apiary_details/presentation/apiary_details_page.dart';
import 'package:hive_note/dashboard/presentation/dashboard_page.dart';
import 'package:hive_note/edit_apiary/presentation/edit_apiary_page.dart';
import 'package:hive_note/edit_hive/presentation/edit_hive_page.dart';
import 'package:hive_note/edit_queen/presentation/edit_queen_page.dart';
import 'package:hive_note/feeding/presentation/feeding_page.dart';
import 'package:hive_note/finances/presentation/finances_page.dart';
import 'package:hive_note/harves/presentation/harvest_page.dart';
import 'package:hive_note/history/presentation/history_page.dart';
import 'package:hive_note/hive_details/presentation/hive_details_page.dart';
import 'package:hive_note/inspection/presentation/inspection_page.dart';
import 'package:hive_note/manage_apiaries/presentation/manage_apiaries_page.dart';
import 'package:hive_note/manage_hives/presentation/manage_hives_page.dart';
import 'package:hive_note/manage_queens/presentation/manage_queens_page.dart';
import 'package:hive_note/manage_todos/presentation/manage_todos_page.dart';
import 'package:hive_note/navigation/presentation/pages/records.dart';
import 'package:hive_note/note/presentation/note_page.dart';
import 'package:hive_note/queen_details/presentation/queen_details_page.dart';
import 'package:hive_note/raport_details/presentation/raport_details_page.dart';
import 'package:hive_note/shared/presentation/pages/tmp_page.dart';
import 'package:hive_note/statistics/presentation/statistics_page.dart';
import 'package:hive_note/todo_details/presentation/todo_details_page.dart';
import 'package:hive_note/treatment/presentation/treatment_page.dart';

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
  static const String inspectionPath = '/inspection_path';
  static const String harvestPath = '/harvest_path';
  static const String financesPath = '/finances_path';
  static const String feedingPath = '/feeding_path';
  static const String treatmentPath = '/treatment_path';
  static const String historyPath = '/history_path';
  static const String notePath = '/note_path';
  static const String statisticsPath = '/statistics_path';
  static const String apiaryDetailsPath = '/apiary_details';
  static const String hiveDetailsPath = '/hive_details';
  static const String queenDetailsPath = '/queen_details';
  static const String raportDetailsPath = '/raport_details';
  static const String todoDetailsPath = '/todo_details';

  static Route<dynamic> onGeneratedRoute(RouteSettings settings) {
    final args = settings.arguments;

    // Routes without parameters
    final routes = <String, WidgetBuilder>{
      emptyPath: (_) => const DashboardPage(),
      dashboardPath: (_) => const DashboardPage(),
      tmpPath: (_) => const TMPPage(),
      manageTodosPath: (_) => const ManageTodosPage(),
      recordsPath: (_) => const RecordsPage(),
      manageApiariesPath: (_) => const ManageApiariesPage(),
      manageHivesPath: (_) => const ManageHivesPage(),
      manageQueensPath: (_) => const ManageQueensPage(),
      harvestPath: (_) => const HarvestPage(),
      financesPath: (_) => const FinancesPage(),
      feedingPath: (_) => const FeedingPage(),
      treatmentPath: (_) => const TreatmentPage(),
      historyPath: (_) => const HistoryPage(),
      notePath: (_) => const NotePage(),
      statisticsPath: (_) => const StatisticsPage(),
    };

    final builder = routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute(builder: builder);
    }

    // Routes with parameters
    switch (settings.name) {
      case editApiaryPath:
        return MaterialPageRoute(
          builder: (_) => EditApiaryPage(apiaryId: args as String),
        );
      case editHivePath:
        return MaterialPageRoute(
          builder: (_) => EditHivePage(hiveId: args as String),
        );
      case editQueenPath:
        return MaterialPageRoute(
          builder: (_) => EditQueenPage(queenId: args as String),
        );
      case inspectionPath:
        return MaterialPageRoute(
          builder: (_) => InspectionPage(apiaryId: args as String),
        );
      case apiaryDetailsPath:
        return MaterialPageRoute(
          builder: (_) => ApiaryDetailsPage(apiaryId: args as String),
        );
      case hiveDetailsPath:
        return MaterialPageRoute(
          builder: (_) => HiveDetailsPage(hiveId: args as String),
        );
      case queenDetailsPath:
        return MaterialPageRoute(
          builder: (_) => QueenDetailsPage(queenId: args as String),
        );
      case raportDetailsPath:
        return MaterialPageRoute(
          builder: (_) => RaportDetailsPage(raportId: args as String),
        );
      case todoDetailsPath:
        return MaterialPageRoute(
          builder: (_) => TodoDetailsPage(todoId: args as String),
        );
      default:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
    }
  }
}
