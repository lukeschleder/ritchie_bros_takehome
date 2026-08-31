import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const navy = Color(0xFF1B365D);
  static const gold = Color(0xFFC8960C);
  static const lightSurface = Color(0xFFF3F5F8);

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: navy,
      primary: navy,
      secondary: gold,
      surface: lightSurface,
      brightness: Brightness.light,
    );

    return _base(colorScheme).copyWith(
      scaffoldBackgroundColor: lightSurface,
    );
  }

  static ThemeData get dark {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: navy,
      primary: const Color(0xFF8FB3E8),
      secondary: gold,
      brightness: Brightness.dark,
    );

    return _base(colorScheme);
  }

  static ThemeData _base(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.brightness == Brightness.dark
            ? colorScheme.surfaceContainerHigh
            : Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: navy,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }
}
