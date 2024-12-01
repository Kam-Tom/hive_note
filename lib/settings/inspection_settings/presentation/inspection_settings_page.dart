
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/settings/inspection_settings/bloc/inspection_settings_bloc.dart';
import 'package:hive_note/settings/inspection_settings/presentation/inspection_settings_view.dart';
import 'package:repositories/repositories.dart';

class InspectionSettingsPage extends StatelessWidget {
  const InspectionSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InspectionSettingsBloc(
        entryMetadataRepository: context.read<EntryMetadataRepository>(),
      )..add(LoadEntries(type: RaportType.values.first)),
      child: const InspectionSettingsView(),
    );
  }
}