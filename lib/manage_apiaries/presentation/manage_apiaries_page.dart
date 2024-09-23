import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_note/core/configs/assets/app_vectors.dart';
import 'package:hive_note/core/configs/setup/app_router.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/manage_apiaries/bloc/manage_apiaries_bloc.dart';
import 'package:hive_note/manage_apiaries/presentation/manage_apiaries_view.dart';
import 'package:hive_note/shared/presentation/widgets/widgets.dart';
import 'package:repositories/repositories.dart';

class ManageApiariesPage extends StatelessWidget {
  const ManageApiariesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocProvider(
        create: (context) => ManageApiariesBloc(
          apiaryRepository: context.read<ApiaryRepository>(),
        )..add(const ManageApiariesSubscriptionRequest()),
        child: const ManageApiariesView(),
      ),
      bottomNavigationBar: CustomAppFooter(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.of(context).pushNamed(AppRouter.manageHivesPath);
        },
        child: SvgPicture.asset(
          AppVectors.manageHives,
          width: 36,
          height: 36,
        ),
      ),
    );
  }
}
