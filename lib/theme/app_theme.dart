import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF6F4E37),
    scaffoldBackgroundColor: const Color(0xFFF9F6EF),
    appBarTheme: const AppBarTheme(
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
    textTheme: ThemeData.light().textTheme.apply(
      fontFamily: GoogleFonts.playfairDisplay().fontFamily,
      bodyColor: const Color(0xFF3E2F21),
      displayColor: const Color(0xFF3E2F21),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6F4E37),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    iconTheme: const IconThemeData(color: Color(0xFF6F4E37)),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF2B2B2B),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF1F1F1F),
      foregroundColor: Colors.white,
    ),
    textTheme: ThemeData.dark().textTheme.apply(
      fontFamily: GoogleFonts.playfairDisplay().fontFamily,
      bodyColor: Colors.white70,
      displayColor: Colors.white70,
    ),
  );
}
