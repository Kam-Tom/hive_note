import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/settings/preferences/bloc/preferences_bloc.dart';
import 'package:hive_note/settings/preferences/presentation/preferences_view.dart';
import 'package:repositories/repositories.dart';

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PreferencesBloc(
        preferencesRepository: context.read<PreferencesRepository>(),
      ),
      child: const PreferencesView(),
    );
  }

}
