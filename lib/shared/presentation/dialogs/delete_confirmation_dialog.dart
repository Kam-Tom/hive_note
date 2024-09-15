import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';

Future<bool?> showDeleteConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (_) => const _DeleteConfirmationDialog(),
  );
}

class _DeleteConfirmationDialog extends StatelessWidget {
  const _DeleteConfirmationDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('confirm_deletion'.tr(),
      style: Theme.of(context)
                .textTheme
                .headlineMedium,
          ),
      backgroundColor: AppColors.background,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'cancel'.tr(),
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: AppColors.textLight),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            'delete'.tr(),
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: AppColors.failure),
          ),
        ),
      ],
    );
  }
}
