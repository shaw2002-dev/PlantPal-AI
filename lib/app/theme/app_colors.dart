import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF2E7D32);
  static const Color secondary = Color(0xFF43A047);
  static const Color accent = Color(0xFF81C784);

  // Background
  static const Color scaffold = Color(0xFFF6FBF6);
  static const Color surface = Colors.white;
  static const Color card = Colors.white;

  // Text
  static const Color textPrimary = Color(0xFF1B1B1B);
  static const Color textSecondary = Color(0xFF6B7280);

  // Status
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFB300);
  static const Color error = Color(0xFFE53935);

  // Borders
  static const Color border = Color(0xFFE5E7EB);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFF2E7D32),
      Color(0xFF66BB6A),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Dark Theme
  static const Color darkScaffold = Color(0xFF121212);

  static const Color darkCard = Color(0xFF1E1E1E);

  static const Color darkSurface = Color(0xFF2A2A2A);

  static const Color darkText = Colors.white;

  static const Color darkSubtitle = Color(0xFFB3B3B3);
}