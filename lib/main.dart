import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /* loads settings from device preferences */
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String sortAlgorithm = prefs.getString('watchlistSort') ?? 'Alphabetically';
  bool notificationToggledOn = prefs.getBool('notificationToggle') ?? false;
  double thresholdValue = prefs.getDouble('thresholdValue') ?? 5.0;
  int notificationQuantity = prefs.getInt('notificationQuantity') ?? 3;

  /* loads daily reminder settings */
  late TimeOfDay notification1;
  late TimeOfDay notification2;
  late TimeOfDay notification3;

  int tod1Hours = prefs.getInt('tod1Hours') ?? 8;
  int tod2Hours = prefs.getInt('tod2Hours') ?? 12;
  int tod3Hours = prefs.getInt('tod3Hours') ?? 14;

  int tod1Minutes = prefs.getInt('tod1Minutes') ?? 45;
  int tod2Minutes = prefs.getInt('tod2Minutes') ?? 0;
  int tod3Minutes = prefs.getInt('tod3Minutes') ?? 15;

  notification1 = TimeOfDay(hour: tod1Hours, minute: tod1Minutes);
  notification2 = TimeOfDay(hour: tod2Hours, minute: tod2Minutes);
  notification3 = TimeOfDay(hour: tod3Hours, minute: tod3Minutes);

  runApp(MyApp(
      sortAlgorithm: sortAlgorithm,
      notificationToggledOn: notificationToggledOn,
      thresholdValue: thresholdValue,
      notificationQuantity: notificationQuantity,
      notification1: notification1,
      notification2: notification2,
      notification3: notification3));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  String sortAlgorithm;
  bool notificationToggledOn;
  double thresholdValue;
  int notificationQuantity;
  TimeOfDay notification1;
  TimeOfDay notification2;
  TimeOfDay notification3;

  MyApp(
      {super.key,
      required this.sortAlgorithm,
      required this.notificationToggledOn,
      required this.thresholdValue,
      required this.notificationQuantity,
      required this.notification1,
      required this.notification2,
      required this.notification3});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'EBGaramond'),
        home: HomePage(
            sortAlgorithm: sortAlgorithm,
            notificationToggledOn: notificationToggledOn,
            thresholdValue: thresholdValue,
            notificationQuantity: notificationQuantity,
            notification1: notification1,
            notification2: notification2,
            notification3: notification3));
  }
}
