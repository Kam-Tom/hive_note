import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';

class TodoCardError extends StatelessWidget {
  final VoidCallback onRetry;

  const TodoCardError({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.75;
    return Center(
      child: Container(
        width: width,
        height: 200,
        decoration: _buildBoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: AppColors.failure,
              size: 50,
            ),
            const SizedBox(height: 10),
            Text(
              context.tr("todos_load_failed"),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.failure,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: onRetry,
              child: Text(
                context.tr("tap_to_retry"),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.failure,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.failure,
              ),
              ),
            ),
          ],
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
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
}