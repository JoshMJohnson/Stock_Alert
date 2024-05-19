import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'EBGaramond',
  scaffoldBackgroundColor: const Color(0xFF80D8FF),
  colorScheme: const ColorScheme.light(
    background: Color(0xFFB3E5FC),
    primary: Color(0xFF2979FF),
    secondary: Color(0xFF82B1FF),
    tertiary: Color(0xFF01579B),
  ),
  dividerColor: const Color(0xFF2962FF),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      color: Color(0xFF01579B),
    ),
    bodyMedium: TextStyle(
      color: Color(0xFF0D47A1),
    ),
    bodySmall: TextStyle(
      color: Color(0xFFD50000),
    ),
    bodyLarge: TextStyle(
      color: Color(0xFF1B5E20),
    ),
  ),
  hintColor: const Color(0xFF0D47A1),
  buttonTheme: const ButtonThemeData(
    colorScheme: ColorScheme.light(
      background: Color(0xFF0D47A1),
      primary: Color(0xFF81D4FA),
      secondary: Color(0xFFE1F5FE),
    ),
  ),
  sliderTheme: const SliderThemeData(
    thumbColor: Color(0xFF770000),
    activeTrackColor: Color(0xFF005500),
    inactiveTrackColor: Color(0xFF4CAF50),
    disabledThumbColor: Colors.black,
    disabledActiveTrackColor: Colors.white,
    disabledInactiveTrackColor: Color(0xFF424242),
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      iconColor: Color(0xFF1A237E),
      fillColor: Color(0xFFB3E5FC),
    ),
  ),
  radioTheme: RadioThemeData(fillColor:
      MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    return const Color(0xFF1A237E);
  })),
  iconTheme: const IconThemeData(
    color: Color(0xFF1A237E),
  ),
  cardTheme: const CardTheme(
    color: Color(0xFF2962FF),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'EBGaramond',
  scaffoldBackgroundColor: const Color(0xFF311B92),
  colorScheme: const ColorScheme.dark(
    background: Color(0xFF5C6BC0),
    primary: Color(0xFFBBDEFB),
    secondary: Color.fromARGB(255, 141, 160, 255),
    tertiary: Color(0xFFE8EAF6),
  ),
  dividerColor: Colors.black87,
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      color: Color(0xFF80D8FF),
    ),
    bodyMedium: TextStyle(
      color: Color(0xFFE3F2FD),
    ),
    bodySmall: TextStyle(
      color: Color(0xFFE57373),
    ),
    bodyLarge: TextStyle(
      color: Color(0xFF81C784),
    ),
  ),
  hintColor: Colors.white70,
  buttonTheme: const ButtonThemeData(
    colorScheme: ColorScheme.light(
      background: Colors.black,
      primary: Color.fromARGB(176, 23, 212, 255),
      secondary: Colors.white,
    ),
  ),
  sliderTheme: const SliderThemeData(
    thumbColor: Color(0xFF42A5F5),
    activeTrackColor: Colors.white,
    inactiveTrackColor: Color(0xFF212121),
    disabledThumbColor: Color(0xFF42A5F5),
    disabledActiveTrackColor: Color(0xFFE0E0E0),
    disabledInactiveTrackColor: Color(0xFFE0E0E0),
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      iconColor: Color(0xFF84FFFF),
      fillColor: Colors.black,
    ),
  ),
  radioTheme: RadioThemeData(fillColor:
      MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    return const Color(0xFF84FFFF);
  })),
  iconTheme: const IconThemeData(
    color: Color(0xFF84FFFF),
  ),
  cardTheme: const CardTheme(
    color: Color(0xFFE0E0E0),
  ),
);
