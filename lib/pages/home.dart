import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:stock_alert/helper_functions.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_watchlist.dart';
import 'package:stock_alert/pages/settings.dart';
import 'package:stock_alert/pages/homePageWidgets/ticker_input_fields.dart';
import 'package:stock_alert/pages/homePageWidgets/sort_input_fields.dart';

class HomePage extends StatefulWidget {
  final String startupSortAlgorithm;
  final bool startupNotificationToggledOn;
  final double startupThresholdValue;
  final int startupNotificationQuantity;
  final TimeOfDay startupNotification1;
  final TimeOfDay startupNotification2;
  final TimeOfDay startupNotification3;

  const HomePage(
      this.startupSortAlgorithm,
      this.startupNotificationToggledOn,
      this.startupThresholdValue,
      this.startupNotificationQuantity,
      this.startupNotification1,
      this.startupNotification2,
      this.startupNotification3,
      {super.key});

  @override
  State<HomePage> createState() =>
      // ignore: no_logic_in_create_state
      _HomePageState(
          startupSortAlgorithm,
          startupNotificationToggledOn,
          startupThresholdValue,
          startupNotificationQuantity,
          startupNotification1,
          startupNotification2,
          startupNotification3);
}

class _HomePageState extends State<HomePage> {
  String sortAlgorithm;
  bool notificationToggledOn;
  double thresholdValue;
  int notificationQuantity;
  TimeOfDay notification1;
  TimeOfDay notification2;
  TimeOfDay notification3;

  _HomePageState(
      this.sortAlgorithm,
      this.notificationToggledOn,
      this.thresholdValue,
      this.notificationQuantity,
      this.notification1,
      this.notification2,
      this.notification3);

  /* executes when navigator pops Settings -> Home; updates preference variables */
  settingsToHomeHandler() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    notificationToggledOn = prefs.getBool('notificationToggle')!;
    thresholdValue = prefs.getDouble('thresholdValue')!;
    notificationQuantity = prefs.getInt('notificationQuantity')!;

    /* time of day preference variables */
    final int tod1Hours = prefs.getInt('tod1Hours')!;
    final int tod2Hours = prefs.getInt('tod2Hours')!;
    final int tod3Hours = prefs.getInt('tod3Hours')!;

    final int tod1Minutes = prefs.getInt('tod1Minutes')!;
    final int tod2Minutes = prefs.getInt('tod2Minutes')!;
    final int tod3Minutes = prefs.getInt('tod3Minutes')!;

    notification1 = TimeOfDay(hour: tod1Hours, minute: tod1Minutes);
    notification2 = TimeOfDay(hour: tod2Hours, minute: tod2Minutes);
    notification3 = TimeOfDay(hour: tod3Hours, minute: tod3Minutes);
  }

  /* handles the change in sort algorithm for stock watchlist */
  void sortChangeHandler() async {
    setState(() {
      if (sortAlgorithm == 'Alphabetically') {
        sortAlgorithm = 'Ticker Price';
      } else if (sortAlgorithm == 'Ticker Price') {
        sortAlgorithm = 'Day Change (%)';
      } else if (sortAlgorithm == 'Day Change (%)') {
        sortAlgorithm = 'Stock Exchange';
      } else {
        sortAlgorithm = 'Alphabetically';
      }
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('watchlistSort', sortAlgorithm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context),
      body: homeBody(),
    );
  }

  /* header widget */
  AppBar header(BuildContext context) {
    return AppBar(
        leadingWidth: 110,
        title: Text(
          'Stock Alert',
          style: TextStyle(
              color: Colors.green[900],
              fontSize: 28,
              fontWeight: FontWeight.w900),
        ),
        leading: Image.asset('assets/bull.png'),
        centerTitle: true,
        backgroundColor: Colors.green[200],
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage(
                                notificationToggledOn,
                                thresholdValue,
                                notificationQuantity,
                                notification1,
                                notification2,
                                notification3)))
                    .then((_) => settingsToHomeHandler());
              },
              child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 35, 0),
                  child: Icon(
                    Icons.settings,
                    size: 40,
                    color: Colors.green[900],
                  ))),
        ]);
  }

  /* body widget of settings page */
  Container homeBody() {
    final HelperFunctions helperFunctions = HelperFunctions();

    TimeOfDay? lastUpdatedTime =
        TimeOfDay.now(); // ! get last updated time rather than current time
    String lastUpdatedTimeDisplay =
        helperFunctions.standardTimeConvertionHandler(lastUpdatedTime);

    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0XAA006400), Color(0xFFA5D6A7)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                Image.asset(
                  'assets/bear_bull_fighting.png',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.fill,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TickerInputFields(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: SortInputFields(sortChangeHandler, sortAlgorithm),
                ),
                Expanded(child: StockWatchlist(sortAlgorithm)),
                Text(
                  'Last Updated: $lastUpdatedTimeDisplay',
                  style: const TextStyle(
                      color: Color(0xFFCC0000),
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                )
              ],
            )));
  }
}
