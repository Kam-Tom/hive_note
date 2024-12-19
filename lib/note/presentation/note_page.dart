import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:hive_note/note/bloc/note_bloc.dart';
import 'package:hive_note/note/presentation/note_view.dart';
import 'package:hive_note/shared/features/entry_field.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';
import 'package:repositories/repositories.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NoteBloc(
            raportRepository: context.read<RaportRepository>(),
            entryMetadataRepository: context.read<EntryMetadataRepository>(),
          )..add(const LoadNoteData()),
        ),
        BlocProvider(
          create: (_) => EntryFieldCubit(), 
        ),
      ],
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: const NoteView(),
        bottomNavigationBar: CustomAppFooter(),
        floatingActionButton: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                final entry = context.read<EntryFieldCubit>().getValues();
                if (entry.isEmpty) {
                  Fluttertoast.showToast(
                    msg: 'note_no_data'.tr(),
                    backgroundColor: Colors.red,
                  );
                  return;
                }
                context.read<NoteBloc>().add(CreateNoteEntry(entry: entry));
                context.read<EntryFieldCubit>().clear();
                Fluttertoast.showToast(
                  msg: 'note_created'.tr(),
                  backgroundColor: Colors.green,
                );
              },
              child: const Icon(Icons.send),
            );
          }
        ),
      ),
    );
  }
}
