import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_note/core/configs/assets/app_vectors.dart';
import 'package:hive_note/core/configs/setup/app_router.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/manage_hives/bloc/manage_hives_bloc.dart';
import 'package:hive_note/manage_hives/presentation/manage_hives_view.dart';
import 'package:hive_note/shared/presentation/widgets/widgets.dart';
import 'package:repositories/repositories.dart';

class ManageHivesPage extends StatelessWidget {
  const ManageHivesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isRound: false,
      ),
      body: BlocProvider(
        create: (context) => ManageHivesBloc(
          hiveRepository: context.read<HiveRepository>(),
          preferencesRepository: context.read<PreferencesRepository>(),
        )..add(const Subscribe()),
        child: const ManageHivesView(),
      ),
      bottomNavigationBar: CustomAppFooter(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondary,
        onPressed: () {
          Navigator.of(context).pushNamed(AppRouter.manageQueensPath);
        },
        child: SvgPicture.asset(
          AppVectors.queen,
          width: 36,
          height: 36,
        ),
      ),
    );
  }
}
