import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const pageTransitionsTheme = PageTransitionsTheme(
      builders: {TargetPlatform.android: ZoomPageTransitionsBuilder()});

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: ThemeData.light().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.light(),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.brown.shade700,
      foregroundColor: Colors.white,
    ),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ThemeData.dark().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.dark(),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black54,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
    )),
  );
}
