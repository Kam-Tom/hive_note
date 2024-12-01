import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/settings/inspection_settings/bloc/inspection_settings_bloc.dart';
import 'package:hive_note/settings/inspection_settings/cubit/entry_type_dropdown_cubit.dart';
import 'package:hive_note/settings/inspection_settings/presentation/add_entry_dialog_view.dart';
import 'package:repositories/repositories.dart';

class AddEntryDialog extends StatelessWidget {
  final RaportType raportType;
  final InspectionSettingsBloc bloc;

  const AddEntryDialog({required this.raportType, required this.bloc, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EntryTypeCubit(),
      child: AddEntryDialogView(raportType: raportType, bloc: bloc),
    );
  }
}
