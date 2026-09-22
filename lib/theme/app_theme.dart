import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Flutter Brand Colors
  static const Color flutterBlue = Color(0xFF027DFD);
  static const Color flutterSky = Color(0xFF54C5F8);
  static const Color flutterDart = Color(0xFF00B4AB);
  static const Color accentAmber = Color(0xFFFFC107);
  static const Color accentOrange = Color(0xFFFF6B35);

  // Dark Backgrounds
  static const Color dark = Color(0xFF0A0E1A);
  static const Color dark2 = Color(0xFF111827);
  static const Color dark3 = Color(0xFF1C2333);
  static const Color cardBg = Color(0xFF141C2E);

  // Text
  static const Color textPrimary = Color(0xFFE8F4FD);
  static const Color textMuted = Color(0xFF7A8BA3);
  static const Color white = Color(0xFFFFFFFF);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [flutterBlue, flutterDart],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient skyGradient = LinearGradient(
    colors: [flutterSky, flutterBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: dark,
      colorScheme: const ColorScheme.dark(
        primary: flutterBlue,
        secondary: flutterSky,
        surface: cardBg,
      ),
      textTheme: GoogleFonts.soraTextTheme(
        ThemeData.dark().textTheme,
      ).apply(
        bodyColor: textPrimary,
        displayColor: white,
      ),
      useMaterial3: true,
    );
  }
}
