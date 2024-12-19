import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_note/core/configs/assets/app_vectors.dart';
import 'package:hive_note/core/configs/setup/app_router.dart';
import 'package:hive_note/shared/presentation/widgets/menu_button.dart';
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
            crossAxisCount: 2, 
            crossAxisSpacing: 32.0, 
            mainAxisSpacing: 32.0,
          ),
          children: [
            MenuButton(
              newPage: AppRouter.harvestPath,
              icon: SvgPicture.asset(AppVectors.harvest, width: 50),
              text: Text('harvest'.tr()),
            ),
            MenuButton(
              newPage: AppRouter.financesPath,
              icon: SvgPicture.asset(AppVectors.finances, width: 50),
              text: Text('finances'.tr()),
            ),
            MenuButton(
              newPage: AppRouter.feedingPath,
              icon: SvgPicture.asset(AppVectors.feeding, width: 50),
              text: Text('feeding'.tr()),
            ),
            MenuButton(
              newPage: AppRouter.treatmentPath,
              icon: SvgPicture.asset(AppVectors.treatment, width: 50),
              text: Text('treatment'.tr()),
            ),
            MenuButton(
              newPage: AppRouter.historyPath,
              icon: SvgPicture.asset(AppVectors.history, width: 50),
              text: Text('history'.tr()),
            ),
            MenuButton(
              newPage: AppRouter.notePath,
              icon: SvgPicture.asset(AppVectors.other, width: 50),
              text: Text('note'.tr()),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomAppFooter(),
    );
  }
}