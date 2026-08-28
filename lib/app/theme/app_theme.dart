import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      scaffoldBackgroundColor: AppColors.scaffold,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),

      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),

      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge,
        headlineLarge: AppTypography.headlineLarge,
        headlineMedium: AppTypography.headlineMedium,
        titleLarge: AppTypography.titleLarge,
        titleMedium: AppTypography.titleMedium,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        labelLarge: AppTypography.labelLarge,
      ),

      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(double.infinity, 56),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return lightTheme.copyWith(
      brightness: Brightness.dark,

      scaffoldBackgroundColor: AppColors.darkScaffold,

      cardColor: AppColors.darkCard,

      canvasColor: AppColors.darkScaffold,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(double.infinity, 56),

          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,

          disabledBackgroundColor: AppColors.primary.withOpacity(0.45),
          disabledForegroundColor: Colors.white70,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),

      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),

      dialogTheme: const DialogThemeData(
        backgroundColor: AppColors.darkCard,
      ),

      dividerColor: Colors.white12,

      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge.copyWith(
          color: Colors.white,
        ),
        headlineLarge: AppTypography.headlineLarge.copyWith(
          color: Colors.white,
        ),
        headlineMedium: AppTypography.headlineMedium.copyWith(
          color: Colors.white,
        ),
        titleLarge: AppTypography.titleLarge.copyWith(
          color: Colors.white,
        ),
        titleMedium: AppTypography.titleMedium.copyWith(
          color: Colors.white,
        ),
        bodyLarge: AppTypography.bodyLarge.copyWith(
          color: Colors.white,
        ),
        bodyMedium: AppTypography.bodyMedium.copyWith(
          color: Colors.white,
        ),
        labelLarge: AppTypography.labelLarge.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}