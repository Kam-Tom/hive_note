import 'package:flutter/material.dart';
import 'package:hive_note/core/configs/icon_mappers/todo_category_icons.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart'; // Assuming this is where colors are defined
import 'package:easy_localization/easy_localization.dart';
import 'package:repositories/repositories.dart';

class TodoDetailsModal extends StatelessWidget {
  final Todo todo;

  const TodoDetailsModal({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ensure it takes minimum height
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 20),
          _buildCategoryRow(context),
          const SizedBox(height: 15),
          _buildDescription(context),
          const SizedBox(height: 15),
          _buildDueDate(context),
          const SizedBox(height: 20),
          _buildCompletionStatus(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          todo.location,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textLight,
              ),
        ),
        const Icon(
          Icons.location_on,
          color: Colors.grey, // Neutral color
        ),
      ],
    );
  }

  Widget _buildCategoryRow(BuildContext context) {
    return Row(
      children: [
        TodoCategoryIcons.categoryIcons[todo.categoryType]!,
        const SizedBox(width: 10),
        Text(
          todo.categoryType.name.tr(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      todo.description,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
    );
  }

  Widget _buildDueDate(BuildContext context) {
    final String formattedDate = DateFormat.yMMMd().format(todo.dueTo);
    return Row(
      children: [
        const Icon(Icons.calendar_today, color: Colors.grey),
        const SizedBox(width: 10),
        Text(
          '${"due_date".tr()}: $formattedDate',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
        ),
      ],
    );
  }

  Widget _buildCompletionStatus(BuildContext context) {
    return Row(
      children: [
        Icon(
          todo.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: todo.isCompleted ? Colors.green : Colors.grey,
        ),
        const SizedBox(width: 10),
        Text(
          todo.isCompleted ? "todo_completed".tr() : "todo_pending".tr(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight:
                    todo.isCompleted ? FontWeight.bold : FontWeight.normal,
              ),
        ),
      ],
    );
  }
}
