import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryTeal = Color(0xff00A896);
  static const Color secondaryTeal = Color(0xff028090);
  static const Color backgroundMist = Color(0xffF4F7F6);
  static const Color textSlate = Color(0xff1E293B);
  static const Color mutedText = Color(0xff64748B);
  static const Color softCardBorder = Color(0xffE2E8F0);
  static const Color alertCoral = Color(0xffEF4444);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryTeal,
      scaffoldBackgroundColor: backgroundMist,
      colorScheme: const ColorScheme.light(
        primary: primaryTeal,
        secondary: secondaryTeal,
        surface: Colors.white,
        error: alertCoral,
      ),
      fontFamily: 'Inter',
      // Changed from CardTheme to CardThemeData to match latest Flutter APIs
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: softCardBorder, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: softCardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: softCardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryTeal, width: 1.5),
        ),
      ),
    );
  }
}