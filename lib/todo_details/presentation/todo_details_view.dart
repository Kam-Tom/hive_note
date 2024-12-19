import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/core/configs/icon_mappers/todo_category_icons.dart';
import 'package:hive_note/todo_details/cubit/todo_details_cubit.dart';

class TodoDetailsView extends StatelessWidget {
  const TodoDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoDetailsCubit, TodoDetailsState>(
      builder: (context, state) {
        return switch (state) {
          TodoDetailsLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          TodoDetailsSuccess() => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'todo_information'.tr(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTodoCard(state),
                ],
              ),
            ),
          TodoDetailsError() => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    size: 48,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'todo_not_found'.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'todo_might_be_deleted'.tr(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          _ => const SizedBox(),
        };
      },
    );
  }

  Widget _buildTodoCard(TodoDetailsSuccess state) {
    final formattedDate = DateFormat('MMMM d, y').format(state.todo.dueTo);
    
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.todo.location,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                state.todo.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: TodoCategoryIcons.categoryIcons[state.todo.categoryType]!,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    state.todo.categoryType.name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    state.todo.isCompleted 
                        ? Icons.check_circle 
                        : Icons.pending,
                    color: state.todo.isCompleted 
                        ? Colors.green 
                        : Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    state.todo.isCompleted ? 'todo_completed'.tr() : 'todo_pending'.tr(),
                    style: TextStyle(
                      fontSize: 16,
                      color: state.todo.isCompleted 
                          ? Colors.green 
                          : Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'due_to'.tr(args: [formattedDate]),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
