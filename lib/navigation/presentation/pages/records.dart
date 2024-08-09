import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_note/core/configs/assets/app_vectors.dart';
import 'package:hive_note/navigation/presentation/pages/feeding.dart';
import 'package:hive_note/navigation/presentation/pages/finances.dart';
import 'package:hive_note/navigation/presentation/pages/harvest.dart';
import 'package:hive_note/navigation/presentation/pages/history.dart';
import 'package:hive_note/navigation/presentation/pages/other.dart';
import 'package:hive_note/navigation/presentation/pages/treatment.dart';
import 'package:hive_note/navigation/presentation/widgets/menu_button.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';

class RecordsPage extends StatelessWidget {
  const RecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: GridView(
          padding: const EdgeInsets.all(64.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 32.0, // Horizontal spacing between items
            mainAxisSpacing: 32.0, // Vertical spacing between items
          ),
          children: [
            MenuButton(
              newPage: const HarvestPage(),
              icon: SvgPicture.asset(AppVectors.harvest, width: 50),
              text: const Text('Harvest'),
            ),
            MenuButton(
              newPage: const FinancesPage(),
              icon: SvgPicture.asset(AppVectors.finances, width: 50),
              text: const Text('Finances'),
            ),
            MenuButton(
              newPage: const FeedingPage(),
              icon: SvgPicture.asset(AppVectors.feeding, width: 50),
              text: const Text('Feeding'),
            ),
            MenuButton(
              newPage: const TreatmentPage(),
              icon: SvgPicture.asset(AppVectors.treatment, width: 50),
              text: const Text('Treatment'),
            ),
            MenuButton(
              newPage: const HistoryPage(),
              icon: SvgPicture.asset(AppVectors.history, width: 50),
              text: const Text('History'),
            ),
            MenuButton(
              newPage: const OtherPage(),
              icon: SvgPicture.asset(AppVectors.other, width: 50),
              text: const Text('Other'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomAppFooter(),
    );
  }
}