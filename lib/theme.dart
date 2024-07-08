import 'package:flutter/material.dart';

// * light theme
// todo
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
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 154, 255, 154),
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 7, 88, 7),
      ),
    ),
  ),
  buttonTheme: const ButtonThemeData(
    colorScheme: ColorScheme.light(
      background: Color(0xFF0D47A1),
      primary: Color(0xFF81D4FA),
      secondary: Color(0xFFE1F5FE),
    ),
  ),
  sliderTheme: const SliderThemeData(
    thumbColor: Color(0xFF0D47A1),
    activeTrackColor: Color(0xFF2196F3),
    inactiveTrackColor: Color(0xFF1A237E),
    disabledThumbColor: Color(0xFF0D47A1),
    disabledActiveTrackColor: Color(0xFF2196F3),
    disabledInactiveTrackColor: Color(0xFF2196F3),
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
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFF0B290A),
  ),
);

// * dark theme
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'EBGaramond',
  // bottom background color
  scaffoldBackgroundColor: const Color(0xFF0B290A),
  colorScheme: const ColorScheme.dark(
    // top background color
    background: Color(0xFF145714),
    // bottom watchlist background color
    primary: Color.fromARGB(255, 103, 12, 12),
    // top watchlist background color
    secondary: Color.fromARGB(255, 57, 0, 0),
    // basic text; watchlist/popup
    tertiary: Color.fromARGB(255, 255, 255, 255),
  ),
  // watchlist divider
  dividerColor: const Color.fromARGB(255, 170, 8, 8),
  textTheme: const TextTheme(
    // header font
    headlineMedium: TextStyle(
      color: Color.fromARGB(255, 154, 255, 154),
    ),
    // normal font
    bodyMedium: TextStyle(
      color: Color.fromARGB(255, 154, 255, 154),
    ),
    // bear red
    bodySmall: TextStyle(
      color: Color(0xFFE57373),
    ),
    // bull green
    bodyLarge: TextStyle(
      color: Color(0xFF81C784),
    ),
  ),
  // text input field untouched - home page
  hintColor: const Color.fromARGB(255, 154, 255, 154),
  // ticker symbol input field - home page
  inputDecorationTheme: const InputDecorationTheme(
    // text field selected
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 255, 255, 255),
      ),
    ),
    // text field not selected
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 154, 255, 154),
      ),
    ),
  ),
  // buttons
  buttonTheme: const ButtonThemeData(
    colorScheme: ColorScheme.light(
      background: Colors.black,
      primary: Color(0xFF1E88E5),
      secondary: Colors.white,
    ),
  ),
  // slider - ticker page & settings
  sliderTheme: const SliderThemeData(
    thumbColor: Color(0xFF42A5F5),
    activeTrackColor: Color(0xFF9FA8DA),
    inactiveTrackColor: Color(0xFF3F51B5),
    disabledThumbColor: Color(0xFFE3F2FD),
    disabledActiveTrackColor: Color(0xFF9FA8DA),
    disabledInactiveTrackColor: Color(0xFF9FA8DA),
  ),
  // dropdown - quantity reminders in settings
  dropdownMenuTheme: const DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      iconColor: Color(0xFFBBDEFB),
      fillColor: Colors.black,
    ),
  ),
  // radio buttons in settings
  radioTheme: RadioThemeData(fillColor:
      MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    return const Color(0xFFBBDEFB);
  })),
  // icons
  iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 154, 255, 154),
  ),
  // border; popup/tickerPage
  cardTheme: const CardTheme(
    color: Color(0xFFE0E0E0),
  ),
  // popup displays
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFF0B290A),
  ),
);
