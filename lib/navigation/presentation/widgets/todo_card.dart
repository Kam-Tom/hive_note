import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/navigation/models/todo.dart';

class ToDoCard extends StatelessWidget {
  final ToDo toDo;
  final void Function(ToDo toDo) onPressed;
  
  const ToDoCard({
    super.key,
    required this.toDo, 
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(toDo),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        padding: EdgeInsets.zero,
      ),
      child: Container(
        decoration: const BoxDecoration(
          border: GradientBoxBorder(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(150, 255, 255, 255),
                Color.fromARGB(0, 255, 255, 255),
                Color.fromARGB(150, 255, 255, 255),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            width: 3,
          ),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              _buildDate(context),
              _buildDescription(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          toDo.apiaryName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
       
      ],
    );
  }

  Widget _buildDate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        _formatDate(toDo.date),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          toDo.description,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}