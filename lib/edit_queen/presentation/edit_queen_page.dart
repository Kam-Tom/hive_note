import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/edit_queen/bloc/edit_queen_bloc.dart';
import 'package:hive_note/edit_queen/presentation/edit_queen_view.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';
import 'package:repositories/repositories.dart';

class EditQueenPage extends StatelessWidget {
  const EditQueenPage({super.key, required this.queenId});

  final String queenId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocProvider(
        create: (context) {
          final bloc = EditQueenBloc(
            queenRepository: context.read<QueenRepository>(),
          );
          bloc.add(LoadQueen(queenId: queenId));
          return bloc;
        },
        child: const EditQueenView(),
      ),
      bottomNavigationBar: CustomAppFooter(),
    );
  }
}
