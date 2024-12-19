import 'package:flutter/material.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';

class MenuButton extends StatelessWidget {
  final String newPage;
  final Widget icon;
  final Widget text;

  const MenuButton(
      {super.key,
      required this.newPage,
      required this.icon,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => 
      {
        Navigator.pushNamed(context, newPage),
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Reduced border radius
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      ),
      child: SizedBox(
        width: 115, // Middle ground between 100 and 130
        height: 100, // Middle ground between 90 and 110
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 8), // Slightly increased spacing
            text,
          ],
        ),
      ),
    );
  }
}
