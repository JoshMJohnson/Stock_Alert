import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'EBGaramond',
  colorScheme: ColorScheme.light(
      background: Colors.grey.shade400,
      primary: const Color(0xFFCC0000),
      secondary: const Color(0xFF1B5E20),
      tertiary: const Color(0xFFCC0000)),
  dividerColor: const Color(0xFF1B5E20),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'EBGaramond',
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade400,
    primary: Colors.grey.shade400,
    secondary: Colors.grey.shade400,
    tertiary: Colors.grey.shade400,
  ),
  dividerColor: const Color.fromARGB(255, 6, 20, 7),
);
