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
  buttonTheme: const ButtonThemeData(
    colorScheme: ColorScheme.light(
      background: Color(0xFF005500),
      primary: Color(0xFFC8E6C9),
      secondary: Color(0xFF00FF00),
      tertiary: Color(0xFFC8E6C9),
    ),
  ),
  sliderTheme: const SliderThemeData(
    thumbColor: Color(0xFF1B5E20),
    activeTrackColor: Color(0xFF005500),
    inactiveTrackColor: Color(0xFF4CAF50),
    disabledThumbColor: Colors.black,
    disabledActiveTrackColor: Colors.white,
    disabledInactiveTrackColor: Color(0xFF424242),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'EBGaramond',
  colorScheme: ColorScheme.dark(
    background: const Color(0xFF424242),
    primary: const Color(0xFF757575),
    secondary: Colors.white,
    tertiary: Colors.grey.shade100,
  ),
  dividerColor: Colors.black87,
  textTheme: const TextTheme(
    displayMedium: TextStyle(color: Colors.white),
  ),
  hintColor: Colors.white70,
  buttonTheme: const ButtonThemeData(
    colorScheme: ColorScheme.light(
      background: Colors.black,
      primary: Color(0xFF9E9E9E),
      secondary: Colors.white,
      tertiary: Color(0xFF424242),
    ),
  ),
  sliderTheme: const SliderThemeData(
    thumbColor: Colors.black,
    activeTrackColor: Colors.white,
    inactiveTrackColor: Color(0xFF212121),
    disabledThumbColor: Colors.black,
    disabledActiveTrackColor: Colors.white,
    disabledInactiveTrackColor: Color(0xFF424242),
  ),
);
