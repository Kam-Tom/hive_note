import 'package:flutter/material.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';

class AddTile extends StatelessWidget {
  final void Function() onPressed;

  const AddTile({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.white,
          elevation: 3,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        child: const Column(
          children: [Icon(Icons.add_circle_outline)],
        ),
      ),
    );
  }
}
