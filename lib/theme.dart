import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'EBGaramond',
  colorScheme: const ColorScheme.light(
      background: Color(0xFF006400),
      primary: Colors.black,
      secondary: Color(0xFF1B5E20),
      tertiary: Color(0xFFCC0000)),
  dividerColor: const Color(0xFF1B5E20),
  textTheme: const TextTheme(displayMedium: TextStyle(color: Colors.yellow)),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'EBGaramond',
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: const Color(0xFF212121),
    secondary: Colors.white,
    tertiary: Colors.grey.shade400,
  ),
  dividerColor: const Color.fromARGB(255, 6, 20, 7),
  textTheme: const TextTheme(displayMedium: TextStyle(color: Colors.white)),
);
