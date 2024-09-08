import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';

class TodoCardEmpty extends StatelessWidget {
  final VoidCallback onAddTodo;

  const TodoCardEmpty({
    super.key,
    required this.onAddTodo,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.75;
    return Center(
      child: GestureDetector(
        onTap: onAddTodo,
        child: Container(
          width: width,
          height: 200,
          decoration: _buildBoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_circle_outline,
                color: AppColors.secondary,
                size: 50,
              ),
              const SizedBox(height: 10),
              Text(
                "no_todos".tr(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "tap_to_add_todo".tr(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.secondary,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: AppColors.primaryLight,
      border: Border.all(
        color: const Color.fromARGB(125, 255, 255, 255),
        width: 5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // Changes the position of the shadow.
        ),
      ],
    );
  }
}