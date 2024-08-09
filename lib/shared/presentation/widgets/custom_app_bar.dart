import 'package:flutter/material.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';

class CustomAppBar extends AppBar {
  final bool isRound;
  final bool isFirstScreen;

  CustomAppBar({super.key, this.isRound = true, this.isFirstScreen = false})
      : super(
          backgroundColor: AppColors.primary,
          surfaceTintColor: AppColors.primary,
          shape: isRound
              ? const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(25.0),
                  ),
                )
              : null,
          titleSpacing: 4,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if(!isFirstScreen) _buildCustomButton(Icons.arrow_back, () {}),
              _buildCustomButton(Icons.mic_none, () {}),
            ],
          ),
        );

  static Widget _buildCustomButton(IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: 40,
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: const CircleBorder(),
              backgroundColor: AppColors.secondary,
              elevation: 3
              ),
          onPressed: onPressed,
          child: Icon(
            icon,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
