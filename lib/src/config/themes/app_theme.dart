import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qaza_tracker/src/config/constants/constants.dart';

class AppTheme {
  AppTheme._();

  static const pageTransitionsTheme = PageTransitionsTheme(
      builders: {TargetPlatform.android: ZoomPageTransitionsBuilder()});

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: ThemeData.light().scaffoldBackgroundColor,
    cupertinoOverrideTheme:
        const CupertinoThemeData(brightness: Brightness.light),
    pageTransitionsTheme: pageTransitionsTheme,
    colorScheme: const ColorScheme.light(),
    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: Colors.blue,
      selectionColor: Colors.blue,
      cursorColor: Colors.blue,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(10),
      focusColor: Colors.blue,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius)),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
      shape: const CircleBorder(),
      minimumSize: const Size(45, 45),
    )),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size.fromHeight(50)))),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ThemeData.dark().scaffoldBackgroundColor,
    cupertinoOverrideTheme:
    const CupertinoThemeData(brightness: Brightness.light),
    pageTransitionsTheme: pageTransitionsTheme,
    colorScheme: const ColorScheme.dark(),
    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: Colors.blue,
      selectionColor: Colors.blue,
      cursorColor: Colors.blue,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(10),
      focusColor: Colors.blue,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius)),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: const CircleBorder(),
          minimumSize: const Size(45, 45),
        )),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size.fromHeight(50)))),
  );
}
