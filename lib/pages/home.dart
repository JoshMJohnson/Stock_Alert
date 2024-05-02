import 'package:flutter/material.dart';

import 'package:stock_alert/helper_functions.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_watchlist.dart';
import 'package:stock_alert/pages/settings.dart';
import 'package:stock_alert/pages/homePageWidgets/ticker_input_fields.dart';
import 'package:stock_alert/pages/homePageWidgets/sort_input_fields.dart';

class HomePage extends StatefulWidget {
  final String startupSortAlgorithm;
  final bool startupNotificationToggledOn;
  const HomePage(this.startupSortAlgorithm, this.startupNotificationToggledOn,
      {super.key});

  @override
  State<HomePage> createState() =>
      // ignore: no_logic_in_create_state
      _HomePageState(startupSortAlgorithm, startupNotificationToggledOn);
}

class _HomePageState extends State<HomePage> {
  String sortAlgorithm;
  bool notificationToggledOn;
  _HomePageState(this.sortAlgorithm, this.notificationToggledOn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, notificationToggledOn),
      body: homeBody(sortAlgorithm),
    );
  }

  /* header widget */
  AppBar header(BuildContext context, bool notificationToggledOn) {
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
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SettingsPage(notificationToggledOn)));
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
