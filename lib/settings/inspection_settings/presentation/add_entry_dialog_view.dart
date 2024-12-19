import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/settings/inspection_settings/bloc/inspection_settings_bloc.dart';
import 'package:hive_note/settings/inspection_settings/cubit/entry_type_dropdown_cubit.dart';
import 'package:repositories/repositories.dart';
import 'package:hive_note/settings/inspection_settings/extensions/entry_type_extensions.dart';

class AddEntryDialogView extends StatelessWidget {
  final RaportType raportType;
  final InspectionSettingsBloc bloc;
  final labelController = TextEditingController();
  final hintController = TextEditingController();

  AddEntryDialogView({required this.raportType, required this.bloc, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('add_new_data'.tr()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: labelController,
            decoration: InputDecoration(labelText: 'label'.tr()),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: hintController,
            decoration: InputDecoration(labelText: 'hint'.tr()),
          ),
          const SizedBox(height: 10),
          BlocBuilder<EntryTypeCubit, EntryType>(
            builder: (context, selectedType) {
              return DropdownButton<EntryType>(
                value: selectedType,
                items: EntryType.values.map((EntryType type) {
                  return DropdownMenuItem<EntryType>(
                    value: type,
                    child: _buildEntryTypeRow(type),
                  );
                }).toList(),
                onChanged: (type) {
                  context.read<EntryTypeCubit>().setType(type!);
                },
              );
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('cancel'.tr()),
        ),
        TextButton(
          onPressed: () {
            final selectedType = context.read<EntryTypeCubit>().state;
            bloc.add(CreateEntry(
              entry: EntryMetadata(
                label: labelController.text,
                hint: hintController.text,
                valueType: selectedType,
                order: 0,
                raportType: raportType,
              ),
            ));
            Navigator.of(context).pop();
          },
          child: Text('add'.tr()),
        ),
      ],
    );
  }

  Widget _buildEntryTypeRow(EntryType type) {
    return Row(
      children: [
        type.icon,
        const SizedBox(width: 10),
        Text(type.description),
      ],
    );
  }
}