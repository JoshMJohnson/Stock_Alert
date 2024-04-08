import 'package:flutter/material.dart';
import 'package:stock_alert/pages/settings.dart';

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
        title: Text(
          'Stock Alert',
          style: TextStyle(
              color: Colors.green[900],
              fontSize: 28,
              fontWeight: FontWeight.w900),
        ),
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
                  margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: Icon(
                    Icons.settings,
                    size: 35,
                    color: Colors.green[900],
                  ))),
        ]);
  }
}

/* body widget of settings page */
Container homeBody() {
  return Container(
    decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0XAA006400), Color(0xFFA5D6A7)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter)),
  );
}
