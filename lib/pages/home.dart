import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stock_alert/helperClasses/helper_functions.dart';

import 'package:stock_alert/pages/settings.dart';
import 'package:stock_alert/pages/homePageWidgets/ticker_input_fields.dart';
import 'package:stock_alert/pages/homePageWidgets/sort_input_fields.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                        builder: (context) => const SettingsPage()));
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
Container homeBody() {
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
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: SortInputFields(),
              ),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFFF0000))),
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Text(
                            'Stock Ticker $index',
                            style: const TextStyle(
                                color: Color(0xFF1B5E20),
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ));
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                      ))),
              Text(
                'Last Updated: $lastUpdatedTimeDisplay',
                style: TextStyle(color: const Color(0xFFFF0000), fontSize: 16),
              )
            ],
          )));
}
