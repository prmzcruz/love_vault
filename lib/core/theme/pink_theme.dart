import 'package:flutter/material.dart';

class PinkTheme {
  static const Color primaryPink = Color(0xFFFF4081);
  static const Color accentRose = Color(0xFFEC407A);
  static const Color deepPassion = Color(0xFFC2185B);
  static const Color darkMagenta = Color(0xFF880E4F);
  static const Color blushBackground = Color(0xFFFFF0F5);
  static const Color softCardPink = Color(0xFFFFF5F8);
  static const Color creamWhite = Color(0xFFFAFAFA);
  static const Color goldAccent = Color(0xFFFFD700);
  static const Color warmAmber = Color(0xFFFFB300);

  static const LinearGradient romanticGradient = LinearGradient(
    colors: [
      Color(0xFFFF80AB),
      Color(0xFFFF4081),
      Color(0xFFC2185B),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient softHeaderGradient = LinearGradient(
    colors: [
      Color(0xFFFFF0F5),
      Color(0xFFFFE4EC),
      Color(0xFFFFD8E4),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [
      Color(0xFFFFE082),
      Color(0xFFFFD54F),
      Color(0xFFFFB300),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryPink,
        primary: primaryPink,
        secondary: accentRose,
        tertiary: goldAccent,
        surface: creamWhite,
        surfaceContainerHigh: softCardPink,
      ),
      scaffoldBackgroundColor: blushBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: darkMagenta),
        titleTextStyle: TextStyle(
          color: darkMagenta,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 4,
        shadowColor: primaryPink.withValues(alpha: 0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPink,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: primaryPink.withValues(alpha: 0.4),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryPink,
        foregroundColor: Colors.white,
        elevation: 6,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: primaryPink,
        unselectedItemColor: Colors.pink.shade200,
        type: BottomNavigationBarType.fixed,
        elevation: 12,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primaryPink.withValues(alpha: 0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primaryPink.withValues(alpha: 0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryPink, width: 2),
        ),
      ),
    );
  }
}
