import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_note/core/configs/icon_mappers/todo_category_icons.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/dashboard/presentation/widgets/todos/square_progress_bar.dart';
import 'package:repositories/repositories.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final void Function(Todo todo) onLongPress;
  final void Function(Todo todo) onTap;

  const TodoCard({
    super.key,
    required this.todo,
    required this.onLongPress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildBoxDecoration(),
      child: BorderProgressBar(
        onLongPress: () => onLongPress(todo),
        onTap: () => onTap(todo),
        strokeWidth: 10,
        borderRadius: BorderRadius.circular(20),
        duration: const Duration(seconds: 1),
        startColor: AppColors.white,
        endColor: AppColors.secondary,
        backgroundColor: AppColors.background,
        isRounded: true,
        child: _TodoContent(todo: todo),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
}

class _TodoContent extends StatelessWidget {
  final Todo todo;

  const _TodoContent({required this.todo});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _contentDecoration(),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TodoHeader(todo: todo),
          const SizedBox(height: 4.0),
          _TodoDate(date: todo.dueTo),
          const SizedBox(height: 8.0),
          Flexible(
            child: _TodoDescription(description: todo.description),
          ),
        ],
      ),
    );
  }

  BoxDecoration _contentDecoration() {
    return BoxDecoration(
      color: AppColors.primaryLight,
      borderRadius: BorderRadius.circular(25),
    );
  }
}

class _TodoHeader extends StatelessWidget {
  final Todo todo;

  const _TodoHeader({required this.todo});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          todo.location,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.textLight,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        TodoCategoryIcons.categoryIcons[todo.categoryType]!,
      ],
    );
  }
}

class _TodoDate extends StatelessWidget {
  final DateTime date;

  const _TodoDate({required this.date});

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat.yMEd().format(date);
    return Text(
      formattedDate,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: AppColors.textLight.withOpacity(0.6),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _TodoDescription extends StatelessWidget {
  final String description;

  const _TodoDescription({required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: 20,
      ),
    );
  }
}