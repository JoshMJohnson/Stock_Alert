import 'package:flutter/material.dart';

// * light theme
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'EBGaramond',
  // bottom background color
  scaffoldBackgroundColor: const Color.fromARGB(255, 136, 236, 140),
  colorScheme: const ColorScheme.light(
    // top background color
    background: Color.fromARGB(255, 157, 255, 157),
    // bottom watchlist background color
    primary: Color.fromARGB(255, 103, 12, 12),
    // top watchlist background color
    secondary: Color.fromARGB(255, 57, 0, 0),
    // basic text; watchlist/popup
    tertiary: Color(0xFFFFFFFF),
  ),
  // watchlist divider
  dividerColor: const Color.fromARGB(255, 255, 0, 0),
  textTheme: const TextTheme(
    // header font
    headlineMedium: TextStyle(
      color: Color.fromARGB(255, 3, 46, 4),
    ),
    // display text
    bodyMedium: TextStyle(
      color: Color.fromARGB(255, 3, 46, 4),
    ),
    // bear red
    bodySmall: TextStyle(
      color: Color.fromARGB(255, 255, 147, 147),
    ),
    // bull green
    bodyLarge: TextStyle(
      color: Color.fromARGB(255, 162, 255, 167),
    ),
  ),
  // text input field untouched - home page
  hintColor: const Color.fromARGB(255, 3, 46, 4),
  // ticker symbol input field - home page
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 7, 88, 7),
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 72, 138, 72),
      ),
    ),
  ),
  // buttons
  buttonTheme: const ButtonThemeData(
    colorScheme: ColorScheme.light(
      background: Color.fromARGB(255, 0, 53, 7),
      primary: Color.fromARGB(255, 133, 255, 150),
      secondary: Color(0xFFE1F5FE),
    ),
  ),
  // slider - ticker page & settings
  sliderTheme: const SliderThemeData(
    thumbColor: Color.fromARGB(255, 20, 145, 37),
    activeTrackColor: Color.fromARGB(255, 60, 174, 75),
    inactiveTrackColor: Color.fromARGB(255, 0, 53, 7),
    disabledThumbColor: Color.fromARGB(255, 20, 145, 37),
    disabledActiveTrackColor: Color.fromARGB(255, 60, 174, 75),
    disabledInactiveTrackColor: Color.fromARGB(255, 0, 53, 7),
  ),
  // dropdown - quantity reminders in settings
  dropdownMenuTheme: const DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      iconColor: Color.fromARGB(255, 3, 46, 4),
      fillColor: Color.fromARGB(255, 124, 254, 142),
    ),
  ),
  // radio buttons in settings
  radioTheme: RadioThemeData(fillColor:
      MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    return const Color.fromARGB(255, 3, 46, 4);
  })),
  // icons
  iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 3, 46, 4),
  ),
  // border; popup/tickerPage
  cardTheme: const CardTheme(
    color: Color.fromARGB(255, 8, 146, 35),
  ),
  // popup displays
  dialogTheme: const DialogTheme(
    backgroundColor: Color.fromARGB(255, 97, 236, 102),
  ),
);

// * dark theme
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'EBGaramond',
  // bottom background color
  scaffoldBackgroundColor: const Color.fromARGB(255, 21, 75, 20),
  colorScheme: const ColorScheme.dark(
    // top background color
    background: Color.fromARGB(124, 125, 182, 76),
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
      color: Color.fromARGB(255, 208, 255, 208),
    ),
    // display text
    bodyMedium: TextStyle(
      color: Color.fromARGB(255, 208, 255, 208),
    ),
    // bear red
    bodySmall: TextStyle(
      color: Color.fromARGB(255, 255, 129, 129),
    ),
    // bull green
    bodyLarge: TextStyle(
      color: Color.fromARGB(255, 162, 255, 167),
    ),
  ),
  // text input field untouched - home page
  hintColor: const Color.fromARGB(255, 208, 255, 208),
  // ticker symbol input field - home page
  inputDecorationTheme: const InputDecorationTheme(
    // text field selected
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 208, 255, 208),
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
      background: Color.fromARGB(255, 0, 0, 0),
      primary: Color.fromARGB(255, 4, 160, 67),
      secondary: Colors.white,
    ),
  ),
  // slider - ticker page & settings
  sliderTheme: const SliderThemeData(
    thumbColor: Color.fromARGB(255, 83, 219, 83),
    activeTrackColor: Color.fromARGB(255, 208, 255, 208),
    inactiveTrackColor: Color.fromARGB(255, 114, 178, 114),
    disabledThumbColor: Color.fromARGB(255, 83, 219, 83),
    disabledActiveTrackColor: Color.fromARGB(255, 208, 255, 208),
    disabledInactiveTrackColor: Color.fromARGB(255, 114, 178, 114),
  ),
  // dropdown - quantity reminders in settings
  dropdownMenuTheme: const DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      iconColor: Color.fromARGB(255, 208, 255, 208),
      fillColor: Color.fromARGB(255, 0, 0, 0),
    ),
  ),
  // radio buttons in settings
  radioTheme: RadioThemeData(fillColor:
      MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    return const Color.fromARGB(255, 208, 255, 208);
  })),
  // icons
  iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 208, 255, 208),
  ),
  // border; popup/tickerPage
  cardTheme: const CardTheme(
    color: Color.fromARGB(255, 94, 255, 94),
  ),
  // popup displays
  dialogTheme: const DialogTheme(
    backgroundColor: Color.fromARGB(255, 25, 112, 23),
  ),
);
