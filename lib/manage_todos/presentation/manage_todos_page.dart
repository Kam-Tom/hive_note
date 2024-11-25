import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/manage_todos/bloc/manage_todos_bloc.dart';
import 'package:hive_note/manage_todos/presentation/manage_todos_view.dart';

import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';
import 'package:repositories/repositories.dart';

class ManageTodosPage extends StatelessWidget {
  const ManageTodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocProvider(
        create: (context) => ManageTodosBloc(
               todoRepository: context.read<TodoRepository>(),
            )..add(LoadTodos()),
        child: const ManageTodosView(),
      ),
      bottomNavigationBar: CustomAppFooter(),
    );
  }
}