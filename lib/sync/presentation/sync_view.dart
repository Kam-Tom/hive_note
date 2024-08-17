import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/sync/bloc/sync_bloc.dart';
import 'package:hive_note/sync/bloc/sync_event.dart';
import 'package:hive_note/sync/bloc/sync_state.dart';
import 'package:hive_note/sync/models/entrie_type.dart';
import 'package:hive_note/sync/presentation/pages/field.dart';

class SyncView extends StatelessWidget {
  const SyncView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyncBloc, SyncState>(
      builder: (context, state) {
        return Column(
          children: [
            Field(
                data: EntrieType(
                  id: 0,
                  name: 'Queen',
                  type: 'bool',
                  hint: 'Is Present',
                ),
                value: context.watch<SyncBloc>().state.syncEnabled,
                onChanged: (value) =>
                    {context.read<SyncBloc>().add(ToggleVoiceControl(value))}),
            Field(
                data: EntrieType(
                  id: 0,
                  name: 'Queen',
                  type: 'bool',
                  hint: 'Is Present',
                ),
                value: context.watch<SyncBloc>().state.syncEnabled,
                onChanged: (value) =>
                    {context.read<SyncBloc>().add(ToggleVoiceControl(value))}),
          ],
        );
      },
    );
  }
}
