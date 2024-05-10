import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_entity.dart';

class TickerPage extends StatelessWidget {
  final Function(String deletingTicker) removeTicker;
  final StockEntity stock;
  const TickerPage(this.removeTicker, this.stock, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: header(context), body: tickerBody());
  }

  /* header of the Ticker page */
  AppBar header(BuildContext context) {
    return AppBar(
      title: Text(
        stock.ticker,
        style: TextStyle(
            color: Colors.green[900],
            fontSize: 28,
            fontWeight: FontWeight.w900),
      ),
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
      actions: [
        SizedBox(
          width: 60,
          child: GestureDetector(
            onTap: () => removeTicker(stock.ticker),
            child: const Icon(Icons.delete, size: 35, color: Color(0xFF1B5E20)),
          ),
        )
      ],
    );
  }

  /* body of the ticker page */
  Container tickerBody() {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0XAA006400), Color(0xFFA5D6A7)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.blue))),
                  child: Text(stock.companyName,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600)),
                ),
                Expanded(
                    child: Text(
                  stock.companyDescription,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.fade),
                )),
                Container(
                  height: 100,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Image.asset(
                              'assets/market_logos/NASDAQ.png'), // ! temp value
                        ),
                      ),
                      Flexible(
                          flex: 1,
                          child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.red, width: 5))))
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  child: const Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            Flexible(flex: 1, child: Placeholder()),
                            Flexible(flex: 1, child: Placeholder())
                          ],
                        ),
                      ),
                      Flexible(flex: 2, child: Placeholder())
                    ],
                  ),
                )
              ],
            )));
  }
}
