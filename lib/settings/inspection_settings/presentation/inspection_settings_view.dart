import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/settings/inspection_settings/bloc/inspection_settings_bloc.dart';
import 'package:hive_note/settings/inspection_settings/presentation/add_entry_dialog.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:hive_note/shared/presentation/dialogs/delete_confirmation_dialog.dart';
import 'package:hive_note/shared/presentation/widgets/add_tile.dart';
import 'package:hive_note/shared/presentation/widgets/failure.dart';
import 'package:repositories/repositories.dart';
import 'package:hive_note/settings/inspection_settings/extensions/entry_type_extensions.dart';

class InspectionSettingsView extends StatelessWidget {
  const InspectionSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: BlocBuilder<InspectionSettingsBloc, InspectionSettingsState>(
        builder: (context, state) {
          if (state.status == Status.failure) {
            return const Failure();
          }
          return Column(
            children: [
              TabBar(
                tabs: RaportType.values.take(3).map((type) {
                  return Tab(text: type.toString().split('.').last);
                }).toList(),
                onTap: (index) {
                  context.read<InspectionSettingsBloc>().add(LoadEntries(type: RaportType.values[index]));
                },
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
              ),
              Expanded(
                child: TabBarView(
                  children: RaportType.values.take(3).map((type) {
                    return ReorderableListView(
                      onReorder: (oldIndex, newIndex) {
                        context.read<InspectionSettingsBloc>().add(ReorderEntries(
                          oldIndex: oldIndex,
                          newIndex: newIndex,
                        ));
                      },
                      children: [
                        for (int index = 0; index < state.entries.length; index++)
                          Dismissible(
                            key: ValueKey(state.entries[index]),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (direction) async {
                              return await showDeleteConfirmationDialog(context);
                            },
                            onDismissed: (direction) {
                              context.read<InspectionSettingsBloc>().add(DeleteEntry(entry: state.entries[index]));
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                            ),
                            child: _buildEntryTile(context, state.entries[index], index),
                          ),
                        _buildAddEntryTile(context),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAddEntryTile(BuildContext context) {
    return AddTile(
      key: const ValueKey("add_entry_tile"),
      onPressed: () {
        showDialog(
          context: context,
          builder: (dialogContext) {
            return AddEntryDialog(
              raportType: context.read<InspectionSettingsBloc>().state.raportType,
              bloc: context.read<InspectionSettingsBloc>(),
            );
          },
        );
      },
    );
  }

  Widget _buildEntryTile(BuildContext context, EntryMetadata entry, int index) {
    return ListTile(
      key: ValueKey(entry),
      title: Text(entry.label),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEntryTypeRow(entry.valueType),
          if (entry.hint.isNotEmpty) Text(entry.hint, style: TextStyle(color: Colors.grey)),
        ],
      ),
      trailing: const Icon(Icons.drag_indicator),
    );
  }

  Widget _buildEntryTypeRow(EntryType type) {
    return Row(
      children: [
        type.icon,
        SizedBox(width: 10),
        Text(type.description),
      ],
    );
  }

  void _confirmAndDelete(BuildContext context, EntryMetadata entry) async {
    final bloc = context.read<InspectionSettingsBloc>();
    final confirmed = await showDeleteConfirmationDialog(context);
    if (confirmed == true) {
      bloc.add(DeleteEntry(entry: entry));
    } else {
      // Reinsert the entry back into the list if deletion is not confirmed
      bloc.add(LoadEntries(type: bloc.state.raportType));
    }
  }
}




