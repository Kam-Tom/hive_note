import 'package:flutter/material.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/core/configs/theme/app_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: AppFonts.textTheme,
    
    // Card theme
    cardTheme: const CardTheme(
      color: AppColors.white,
      elevation: 2,
    ),

    // Input decoration theme
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.secondary),
      ),
      labelStyle: TextStyle(color: AppColors.textLight),
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.text,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),

    
    // Switch theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected) 
          ? AppColors.secondary 
          : AppColors.textLight;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected) 
          ? AppColors.secondaryLight 
          : AppColors.backgroundDark;
      }),
    ),

    // Icon theme
    iconTheme: const IconThemeData(
      color: AppColors.primary,
    ),

    // Dialog theme
    dialogTheme: const DialogTheme(
      backgroundColor: AppColors.white,
      titleTextStyle: TextStyle(
        color: AppColors.text,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColors.secondary.withOpacity(0.3), // Selection overlay
      cursorColor: AppColors.secondary, // Text cursor
      selectionHandleColor: AppColors.secondary, // Selection handles
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.secondary, // Text color
        // Optional: Add more styling if needed
        // backgroundColor: AppColors.secondaryLight.withOpacity(0.1), // Background on hover
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.white,
      headerBackgroundColor: AppColors.primary,
      headerForegroundColor: AppColors.text,
      dayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.text;
        }
        return AppColors.textLight;
      }),
      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.secondary;
        }
        return null;
      }),
      todayForegroundColor: WidgetStateProperty.all(AppColors.primary),
      todayBackgroundColor: WidgetStateProperty.all(AppColors.secondaryLight.withOpacity(0.2)),
      surfaceTintColor: AppColors.background,
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary),
        ),
      ),
      
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.background),
        alignment: Alignment.bottomCenter,

      ),
    ),
  );


}
