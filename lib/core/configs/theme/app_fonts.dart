import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';

class AppFonts {
  static final textTheme = TextTheme(
    titleMedium: GoogleFonts.roboto(
      fontSize: 32,
      fontWeight: FontWeight.normal,
      color: AppColors.textLight,
    ),
    bodyLarge: GoogleFonts.roboto(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: AppColors.textLight,
    ),
  );
}
