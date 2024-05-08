import 'package:flutter/material.dart';

class TickerPage extends StatelessWidget {
  const TickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: header(context), body: tickerBody());
  }

  /* header of the Ticker page */ // todo
  AppBar header(BuildContext context) {
    return AppBar(
      title: Text(
        'Ticker Page',
        style: TextStyle(
            color: Colors.green[900],
            fontSize: 28,
            fontWeight: FontWeight.w900),
      ),
      centerTitle: true,
      backgroundColor: Colors.green[200],
    );
  }

  /* body of the ticker page */ // todo
  Container tickerBody() {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0XAA006400), Color(0xFFA5D6A7)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: const SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [],
                ))));
  }
}
