import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /* loads settings from device preferences */
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String startupSortAlgorithm =
      prefs.getString('watchlistSort') ?? 'Alphabetically';

  final bool startupNotificationToggledOn =
      prefs.getBool('notificationToggle') ?? false;
  // final double thresholdValue = prefs.getDouble('thresholdValue') ?? 5.0;
  // final int notificationQuantity = prefs.getInt('notificationQuantity') ?? 3;

  // /* loads daily reminder settings */
  // final int tod1Hours = prefs.getInt('tod1Hours') ?? 8;
  // final int tod2Hours = prefs.getInt('tod2Hours') ?? 12;
  // final int tod3Hours = prefs.getInt('tod3Hours') ?? 14;

  // final int tod1Minutes = prefs.getInt('tod1Minutes') ?? 45;
  // final int tod2Minutes = prefs.getInt('tod2Minutes') ?? 0;
  // final int tod3Minutes = prefs.getInt('tod3Minutes') ?? 15;

  // final TimeOfDay notification1 =
  //     TimeOfDay(hour: tod1Hours, minute: tod1Minutes);
  // final TimeOfDay notification2 =
  //     TimeOfDay(hour: tod2Hours, minute: tod2Minutes);
  // final TimeOfDay notification3 =
  //     TimeOfDay(hour: tod3Hours, minute: tod3Minutes);

  runApp(MyApp(startupSortAlgorithm, startupNotificationToggledOn));
}

class MyApp extends StatelessWidget {
  final String startupSortAlgorithm;
  final bool startupNotificationToggledOn;
  const MyApp(this.startupSortAlgorithm, this.startupNotificationToggledOn,
      {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'EBGaramond'),
        home: HomePage(startupSortAlgorithm, startupNotificationToggledOn));
  }
}
