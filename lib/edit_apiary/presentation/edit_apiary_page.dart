import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/edit_apiary/bloc/edit_apiary_bloc.dart';
import 'package:hive_note/edit_apiary/presentation/edit_apiary_view.dart';

import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';
import 'package:repositories/repositories.dart';

class EditApiaryPage extends StatelessWidget {
  const EditApiaryPage({super.key, required this.apiaryId});

  final String apiaryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocProvider(
        create: (context) => EditApiaryBloc(
          apiaryRepository: context.read<ApiaryRepository>(),
          hiveRepository: context.read<HiveRepository>(),
          preferencesRepository: context.read<PreferencesRepository>(),
        )..add(LoadApiary(apiaryId: apiaryId)),
        child: const EditApiaryView(),
      ),
      bottomNavigationBar: CustomAppFooter(),
    );
  }
}
