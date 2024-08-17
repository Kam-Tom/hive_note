import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/sync/bloc/sync_bloc.dart';
import 'package:hive_note/sync/presentation/sync_view.dart';

class SyncPage extends StatelessWidget {
  const SyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SyncBloc(),
      child: const SyncView(),
      );
  }

}
