import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HelperFunctions {
  /* returns the time given as parameter as a string showing time in standard time */
  String standardTimeConvertionHandler(TimeOfDay timeGiven) {
    late String standardTime;
    late String todMinutes2Digits;
    late int todHours;
    late int todMinutes;

    /* military -> standard variables */
    bool isAM = true;

    todHours = timeGiven.hour;
    todMinutes = timeGiven.minute;

    todMinutes2Digits = todMinutes.toString().padLeft(2, '0');

    /* military -> standard time */
    if (todHours > 11) {
      todHours -= 12;
      isAM = false;
    }

    todHours == 0 ? todHours = 12 : todHours;

    /* prepares string statement that displays the chosen time */
    if (isAM) {
      standardTime = '$todHours:$todMinutes2Digits am';
    } else {
      standardTime = '$todHours:$todMinutes2Digits pm';
    }

    return standardTime;
  }
}

/* returns an updated text value that is in all caps */
class ChangeToUpperCaseText extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
