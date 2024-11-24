import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/edit_hive/bloc/edit_hive_bloc.dart';
import 'package:hive_note/edit_hive/presentation/edit_hive_view.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';
import 'package:repositories/repositories.dart';

class EditHivePage extends StatelessWidget {
  const EditHivePage({super.key, required this.hiveId});

  final String hiveId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocProvider(
        create: (context) {
          final bloc = EditHiveBloc(
            hiveRepository: context.read<HiveRepository>(),
            queenRepository: context.read<QueenRepository>(),
          );
          bloc.add(LoadHive(hiveId: hiveId));
          bloc.add(const LoadQueens());
          return bloc;
        },
        child: const EditHiveView(),
      ),
      bottomNavigationBar: CustomAppFooter(),
    );
  }
}
