import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/manage_queens/bloc/manage_queens_bloc.dart';
import 'package:hive_note/manage_queens/presentation/manage_queens_view.dart';
import 'package:hive_note/shared/presentation/widgets/widgets.dart';
import 'package:repositories/repositories.dart';

class ManageQueensPage extends StatelessWidget {
  const ManageQueensPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isRound: false,
      ),
      body: BlocProvider(
        create: (context) => ManageQueensBloc(
          queenRepository: context.read<QueenRepository>(),
        )..add(const Subscribe()),
        child: const ManageQueensView(),
      ),
      bottomNavigationBar: CustomAppFooter(),
      
    );
  }
}
