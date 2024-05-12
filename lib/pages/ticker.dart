import 'package:flutter/material.dart';
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
        title: Text(stock.ticker,
            style: TextStyle(
                color: Colors.green[900],
                fontSize: 28,
                fontWeight: FontWeight.w900)),
        backgroundColor: Colors.green[200],
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, size: 35, color: Colors.green[900])),
        actions: [
          SizedBox(
              width: 60,
              child: GestureDetector(
                  onTap: () => removeTicker(stock.ticker),
                  child: const Icon(Icons.delete,
                      size: 35, color: Color(0xFF1B5E20))))
        ]);
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
            child: Column(children: [
              Container(
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.blue))),
                  child: Text(stock.companyName,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600))),
              Expanded(
                  child: Text(stock.companyDescription,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.fade))),
              SizedBox(
                  height: 125,
                  width: double.infinity,
                  child: Row(children: [
                    Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Image.asset(
                                  'assets/market_logos/NASDAQ.png')), // ! temp value
                        )),
                    Flexible(
                        flex: 1,
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.red, width: 4)),
                                child: Column(children: [
                                  const Flexible(
                                      flex: 2,
                                      child: SizedBox(
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: Center(
                                              child: Text('PPS',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600))))),
                                  Flexible(
                                      flex: 3,
                                      child: SizedBox(
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: Center(
                                              child: Text(
                                                  '\$${stock.tickerPrice.toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                      color:
                                                          stock.dayChangePercentage >=
                                                                  0
                                                              ? const Color(
                                                                  0xFF00FF00)
                                                              : const Color(
                                                                  0xFFFF0000),
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.w600)))))
                                ]))))
                  ])),
              SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Row(children: [
                    Flexible(
                        flex: 1,
                        child: Column(children: [
                          Flexible(
                              flex: 3,
                              child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.red, width: 4)),
                                      child: Column(children: [
                                        const Flexible(
                                            flex: 2,
                                            child: SizedBox(
                                                width: double.infinity,
                                                height: double.infinity,
                                                child: Center(
                                                    child: Text('Day Change',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600))))),
                                        Flexible(
                                            flex: 3,
                                            child: SizedBox(
                                                width: double.infinity,
                                                height: double.infinity,
                                                child: Center(
                                                    child: Text(
                                                        '${stock.dayChangePercentage}%',
                                                        style: TextStyle(
                                                            color: stock.dayChangePercentage >=
                                                                    0
                                                                ? const Color(
                                                                    0xFF00FF00)
                                                                : const Color(
                                                                    0xFFFF0000),
                                                            fontSize: 28,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600))))),
                                        Flexible(
                                            flex: 3,
                                            child: SizedBox(
                                                width: double.infinity,
                                                height: double.infinity,
                                                child: Center(
                                                    child: Text(
                                                        '\$${stock.dayChangeDollars}',
                                                        style: TextStyle(
                                                            color: stock.dayChangePercentage >=
                                                                    0
                                                                ? const Color(
                                                                    0xFF00FF00)
                                                                : const Color(
                                                                    0xFFFF0000),
                                                            fontSize: 28,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)))))
                                      ])))),
                          Flexible(
                              flex: 2,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Center(
                                        child: Text('52 Week Range',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600))),
                                    Slider(
                                        value: stock.tickerPrice,
                                        onChanged: null,
                                        min: stock.low52Week,
                                        max: stock.high52Week)
                                  ]))
                        ])),
                    Flexible(
                        flex: 2,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: stock.dayChangePercentage >= 0
                                    ? Image.asset('assets/bull_ticker_page.png',
                                        fit: BoxFit.fill)
                                    : Image.asset('assets/bear_ticker_page.png',
                                        fit: BoxFit.fill))))
                  ]))
            ])));
  }
}
