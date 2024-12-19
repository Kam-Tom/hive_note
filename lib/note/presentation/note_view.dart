import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:hive_note/shared/features/entry_field.dart';
import 'package:hive_note/note/bloc/note_bloc.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state.status == Status.success) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                EntryField(entryMetadata: state.entry!),
                const Divider(),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
