import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/todo_details/cubit/todo_details_cubit.dart';
import 'package:hive_note/todo_details/presentation/todo_details_view.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';
import 'package:repositories/repositories.dart';

class TodoDetailsPage extends StatelessWidget {
  const TodoDetailsPage({
    super.key,
    required this.todoId,
  });

  final String todoId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoDetailsCubit(
        todoRepository: context.read<TodoRepository>(),
      )..loadTodoDetails(todoId),
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: const TodoDetailsView(),
        bottomNavigationBar: CustomAppFooter(),
      ),
    );
  }
}