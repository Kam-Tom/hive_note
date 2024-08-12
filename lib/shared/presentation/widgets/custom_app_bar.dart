import 'package:flutter/material.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/settings/presentation/settings.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isRound;
  final bool isFirstScreen;

  const CustomAppBar(
      {super.key, this.isRound = true, this.isFirstScreen = false});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (!isFirstScreen)
            _buildCustomButton(Icons.arrow_back, () => Navigator.pop(context)),
          if (isFirstScreen)
            _buildCustomButton(
                Icons.settings,
                () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()),
                    )),
          _buildCustomButton(Icons.mic_none, () {}),
        ],
      ),
    );
  }

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
            foregroundColor: AppColors.white,
            elevation: 3,
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
