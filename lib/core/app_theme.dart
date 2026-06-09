import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VicoTheme {
  static const Color creamBg = Color(0xFFF9F9F7);
  static const Color vicoGold = Color(0xFFB89356);
  static const Color vicoBlack = Color(0xFF1A1A1A);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: creamBg,
    primaryColor: vicoBlack,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.playfairDisplay(
          fontSize: 32, fontWeight: FontWeight.bold, color: vicoBlack),
      bodyMedium: GoogleFonts.montserrat(color: vicoBlack),
    ),
  );
}