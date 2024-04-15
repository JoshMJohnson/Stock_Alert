import 'package:flutter/material.dart';

import 'package:stock_alert/pages/settings.dart';
import 'package:stock_alert/pages/homePageWidgets/ticker_input_fields.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
  return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0XAA006400), Color(0xFFA5D6A7)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter)),
      child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset(
                    'assets/bear_bull_fighting.png',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: TickerInsertFields(),
                  )
                ],
              ))));
}
