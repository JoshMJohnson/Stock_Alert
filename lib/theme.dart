import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'EBGaramond',
  colorScheme: const ColorScheme.light(
    background: Color(0xFF4CAF50),
    primary: Color(0xFFC8E6C9),
    secondary: Color(0xFF005500),
    tertiary: Color(0xFF1B5E20),
  ),
  dividerColor: const Color(0xFF1B5E20),
  textTheme: const TextTheme(
    displayMedium: TextStyle(
      color: Color(0xFF770000),
    ),
  ),
  hintColor: const Color(0xFF770000),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'EBGaramond',
  colorScheme: ColorScheme.dark(
    background: const Color(0xFF212121),
    primary: const Color(0xFF9E9E9E),
    secondary: Colors.white,
    tertiary: Colors.grey.shade100,
  ),
  dividerColor: Colors.black87,
  textTheme: const TextTheme(
    displayMedium: TextStyle(color: Colors.white),
  ),
  hintColor: Colors.white54,
);