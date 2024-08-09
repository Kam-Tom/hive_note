import 'package:flutter/material.dart';

import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/core/configs/theme/app_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,

    textTheme: AppFonts.textTheme,

    
  );
}
