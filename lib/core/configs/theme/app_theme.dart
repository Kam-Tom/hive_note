import 'package:flutter/material.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/core/configs/theme/app_fonts.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  static ThemeData get lightTheme => ThemeData(
    // Base theme settings
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: AppFonts.textTheme,
    
    // Input and Form related themes
    inputDecorationTheme: _inputDecorationTheme,
    textSelectionTheme: _textSelectionTheme,
    progressIndicatorTheme: _progressIndicatorTheme,
    
    // Button themes
    elevatedButtonTheme: _elevatedButtonTheme,
    textButtonTheme: _textButtonTheme,
    floatingActionButtonTheme: _floatingActionButtonTheme,
    
    // Component themes
    cardTheme: _cardTheme,
    switchTheme: _switchTheme,
    iconTheme: _iconTheme,
    dialogTheme: _dialogTheme,
    datePickerTheme: _datePickerTheme,
    dropdownMenuTheme: _dropdownMenuTheme,
    checkboxTheme: _checkboxTheme,
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.secondary,
      inactiveTrackColor: AppColors.backgroundDark,
      thumbColor: AppColors.secondary,
      overlayColor: AppColors.secondary.withOpacity(0.2),
      valueIndicatorColor: AppColors.secondary,
      valueIndicatorTextStyle: const TextStyle(
        color: AppColors.white,
      ),
      activeTickMarkColor: AppColors.secondary,
      inactiveTickMarkColor: AppColors.backgroundDark,
    ),
  );

  // Input and Form Themes
  static const InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.secondary),
    ),
    labelStyle: TextStyle(color: AppColors.textLight),
  );

  static final TextSelectionThemeData _textSelectionTheme = TextSelectionThemeData(
    selectionColor: AppColors.secondary.withOpacity(0.3),
    cursorColor: AppColors.secondary,
    selectionHandleColor: AppColors.secondary,
  );

  static const ProgressIndicatorThemeData _progressIndicatorTheme = ProgressIndicatorThemeData(
    color: AppColors.secondary,
  );

  // Button Themes
  static final ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.secondary,
      foregroundColor: AppColors.text,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  );

  static final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.secondary,
    ),
  );

  static const FloatingActionButtonThemeData _floatingActionButtonTheme = FloatingActionButtonThemeData(
    backgroundColor: AppColors.secondary,
    foregroundColor: AppColors.white,
    elevation: 4,
  );

  // Component Themes
  static const CardTheme _cardTheme = CardTheme(
    color: AppColors.white,
    elevation: 2,
  );

  static final SwitchThemeData _switchTheme = SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) =>
      states.contains(WidgetState.selected) ? AppColors.secondary : AppColors.textLight
    ),
    trackColor: WidgetStateProperty.resolveWith((states) =>
      states.contains(WidgetState.selected) ? AppColors.secondaryLight : AppColors.backgroundDark
    ),
  );

  static const IconThemeData _iconTheme = IconThemeData(
    color: AppColors.primary,
  );

  static const DialogTheme _dialogTheme = DialogTheme(
    backgroundColor: AppColors.white,
    titleTextStyle: TextStyle(
      color: AppColors.text,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    // Add these properties for consistent dialog styling
    surfaceTintColor: AppColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );

  static final DatePickerThemeData _datePickerTheme = DatePickerThemeData(
    backgroundColor: AppColors.white,
    headerBackgroundColor: AppColors.primary,
    headerForegroundColor: AppColors.text,
    dayForegroundColor: WidgetStateProperty.resolveWith((states) =>
      states.contains(WidgetState.selected) ? AppColors.text : AppColors.textLight
    ),
    dayBackgroundColor: WidgetStateProperty.resolveWith((states) =>
      states.contains(WidgetState.selected) ? AppColors.secondary : null
    ),
    todayForegroundColor: WidgetStateProperty.all(AppColors.primary),
    todayBackgroundColor: WidgetStateProperty.all(AppColors.secondaryLight.withOpacity(0.2)),
    surfaceTintColor: AppColors.background,
  );

  static const DropdownMenuThemeData _dropdownMenuTheme = DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.secondary),
      ),
    ),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStatePropertyAll(AppColors.background),
      alignment: Alignment.bottomCenter,
    ),
  );

  static final CheckboxThemeData _checkboxTheme = CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      return states.contains(WidgetState.selected) 
          ? AppColors.secondary 
          : AppColors.secondary.withOpacity(0.1);
    }),
    overlayColor: WidgetStateProperty.all(AppColors.secondary.withOpacity(0.1)),
    checkColor: WidgetStateProperty.all(AppColors.white),
    side: BorderSide(color: AppColors.secondary),
  );
}
