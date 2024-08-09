import 'package:flutter/material.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';

class MenuButton extends StatelessWidget {
  final Function onPressed;
  final Widget icon;
  final Widget text;

  const MenuButton({super.key, required this.onPressed, required this.icon, required this.text});

  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Container(
        width: 75,
        height: 125,
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            text,
          ],
        ),
      ),
    );
  }

}