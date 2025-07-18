import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final String _fontFamily = GoogleFonts.playfairDisplay().fontFamily!;

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF6F4E37),
    scaffoldBackgroundColor: const Color(0xFFF9F6EF),
    appBarTheme: AppBarTheme(
      color: Color(0xFF6F4E37),
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    cardTheme: CardTheme(
      color: const Color(0xFFFFFBF2),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    textTheme: TextTheme(
      // Define common text styles here, applying the font family
      displayLarge: TextStyle(fontFamily: _fontFamily, color: const Color(0xFF3E2F21)),
      displayMedium: TextStyle(fontFamily: _fontFamily, color: const Color(0xFF3E2F21)),
      displaySmall: TextStyle(fontFamily: _fontFamily, color: const Color(0xFF3E2F21)),
      headlineLarge: TextStyle(fontFamily: _fontFamily, color: const Color(0xFF3E2F21)),
      headlineMedium: TextStyle(fontFamily: _fontFamily, color: const Color(0xFF3E2F21)),
      headlineSmall: TextStyle(fontFamily: _fontFamily, color: const Color(0xFF3E2F21)),
      titleLarge: TextStyle(fontFamily: _fontFamily, color: const Color(0xFF3E2F21)),
      titleMedium: TextStyle(fontFamily: _fontFamily, color: const Color(0xFF3E2F21)),
      titleSmall: TextStyle(fontFamily: _fontFamily, color: const Color(0xFF3E2F21)),
      bodyLarge: TextStyle(fontFamily: _fontFamily, color: const Color(0xFF3E2F21)),
      bodyMedium: TextStyle(fontFamily: _fontFamily, color: const Color(0xFF3E2F21)),
      bodySmall: TextStyle(fontFamily: _fontFamily, color: const Color(0xFF3E2F21)),
      labelLarge: TextStyle(fontFamily: _fontFamily, color: const Color(0xFF3E2F21)),
      labelMedium: TextStyle(fontFamily: _fontFamily, color: const Color(0xFF3E2F21)),
      labelSmall: TextStyle(fontFamily: _fontFamily, color: const Color(0xFF3E2F21)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6F4E37),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    iconTheme: const IconThemeData(color: Color(0xFF6F4E37)),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF2B2B2B),
    appBarTheme: AppBarTheme(
      color: Color(0xFF1F1F1F),
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(fontFamily: _fontFamily, color: Colors.white70),
      displayMedium: TextStyle(fontFamily: _fontFamily, color: Colors.white70),
      displaySmall: TextStyle(fontFamily: _fontFamily, color: Colors.white70),
      headlineLarge: TextStyle(fontFamily: _fontFamily, color: Colors.white70),
      headlineMedium: TextStyle(fontFamily: _fontFamily, color: Colors.white70),
      headlineSmall: TextStyle(fontFamily: _fontFamily, color: Colors.white70),
      titleLarge: TextStyle(fontFamily: _fontFamily, color: Colors.white70),
      titleMedium: TextStyle(fontFamily: _fontFamily, color: Colors.white70),
      titleSmall: TextStyle(fontFamily: _fontFamily, color: Colors.white70),
      bodyLarge: TextStyle(fontFamily: _fontFamily, color: Colors.white70),
      bodyMedium: TextStyle(fontFamily: _fontFamily, color: Colors.white70),
      bodySmall: TextStyle(fontFamily: _fontFamily, color: Colors.white70),
      labelLarge: TextStyle(fontFamily: _fontFamily, color: Colors.white70),
      labelMedium: TextStyle(fontFamily: _fontFamily, color: Colors.white70),
      labelSmall: TextStyle(fontFamily: _fontFamily, color: Colors.white70),
    ),
    // You might want to define other properties for dark theme as well
  );
}