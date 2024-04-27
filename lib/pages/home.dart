import 'package:flutter/material.dart';

import 'package:stock_alert/helper_functions.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_watchlist.dart';
import 'package:stock_alert/pages/settings.dart';
import 'package:stock_alert/pages/homePageWidgets/ticker_input_fields.dart';
import 'package:stock_alert/pages/homePageWidgets/sort_input_fields.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  String sortAlgorithm;
  bool notificationToggledOn;
  double thresholdValue;
  int notificationQuantity;
  TimeOfDay notification1;
  TimeOfDay notification2;
  TimeOfDay notification3;

  HomePage(
      {super.key,
      required this.sortAlgorithm,
      required this.notificationToggledOn,
      required this.thresholdValue,
      required this.notificationQuantity,
      required this.notification1,
      required this.notification2,
      required this.notification3});

  @override
  // ignore: no_logic_in_create_state
  State<HomePage> createState() => _HomePageState(
      sortAlgorithm,
      notificationToggledOn,
      thresholdValue,
      notificationQuantity,
      notification1,
      notification2,
      notification3);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, notificationToggledOn, thresholdValue,
          notificationQuantity, notification1, notification2, notification3),
      body: homeBody(sortAlgorithm),
    );
  }

  /* header widget */
  AppBar header(
      BuildContext context,
      bool notificationToggledOn,
      double thresholdValue,
      int notificationQuantity,
      TimeOfDay notification1,
      TimeOfDay notification2,
      TimeOfDay notification3) {
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
                            notificationToggledOn: notificationToggledOn,
                            thresholdValue: thresholdValue,
                            notificationQuantity: notificationQuantity,
                            notification1: notification1,
                            notification2: notification2,
                            notification3: notification3)));
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
}

/* body widget of settings page */
Container homeBody(String sortAlgorithm) {
  final HelperFunctions helperFunctions = HelperFunctions();

  TimeOfDay? lastUpdatedTime = TimeOfDay.now();
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
                child: TickerInsertFields(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: SortInputFields(sortAlgorithm: sortAlgorithm),
              ),
              Expanded(child: StockWatchlist(sortAlgorithm: sortAlgorithm)),
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
