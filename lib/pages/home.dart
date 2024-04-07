import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(),
    );
  }

  /* header */
  AppBar header() {
    return AppBar(
        title: Text(
          'Stock Alert',
          style: TextStyle(
              color: Colors.green[900],
              fontSize: 24,
              fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[200],
        actions: [
          GestureDetector(
              onTap: () {},
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
