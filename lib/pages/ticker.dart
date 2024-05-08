import 'package:flutter/material.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_entity.dart';

class TickerPage extends StatelessWidget {
  final StockEntity stock;
  const TickerPage(this.stock, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: header(context), body: tickerBody());
  }

  /* header of the Ticker page */ // todo
  AppBar header(BuildContext context) {
    return AppBar(
      title: Text(
        stock.ticker,
        style: TextStyle(
            color: Colors.green[900],
            fontSize: 28,
            fontWeight: FontWeight.w900),
      ),
      centerTitle: true,
      backgroundColor: Colors.green[200],
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
          size: 35,
          color: Colors.green[900],
        ),
      ),
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
        child: const Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [],
            )));
  }
}
