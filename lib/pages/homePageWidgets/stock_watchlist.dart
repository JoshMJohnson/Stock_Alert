import 'package:flutter/material.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_entity.dart';

// ! begin of testing code
StockEntity stock1 = StockEntity(
    ticker: 'AAPL',
    companyName: 'Apple Inc.',
    tickerPrice: 168.8,
    dayChangeDollars: -1.8,
    dayChangePercentage: -0.8);

StockEntity stock2 = StockEntity(
    ticker: 'MSFTF',
    companyName: 'Microsoft Corp.',
    tickerPrice: 411.08,
    dayChangeDollars: -2.08,
    dayChangePercentage: -0.08);

StockEntity stock3 = StockEntity(
    ticker: 'SNDL',
    companyName:
        'This is the Sundile company timeplate for the name of the company which is very long here you got yaa fam you know swap',
    tickerPrice: 189.00,
    dayChangeDollars: 43.00,
    dayChangePercentage: 10.00);

StockEntity stock4 = StockEntity(
    ticker: 'SPOT',
    companyName: 'Spotify',
    tickerPrice: 4,
    dayChangeDollars: -17,
    dayChangePercentage: -13);

StockEntity stock5 = StockEntity(
    ticker: 'OGI',
    companyName: 'Organic Company',
    tickerPrice: 4.90,
    dayChangeDollars: 4.90,
    dayChangePercentage: 4.90);

StockEntity stock6 = StockEntity(
    ticker: 'ADBE',
    companyName: 'Adobe',
    tickerPrice: 120.20,
    dayChangeDollars: 10.10,
    dayChangePercentage: 10.10);

List<StockEntity> testingList = [
  stock1,
  stock2,
  stock3,
  stock4,
  stock5,
  stock6
];
// ! end of testing code

class StockWatchlist extends StatefulWidget {
  const StockWatchlist({super.key});

  @override
  State<StockWatchlist> createState() => _StockWatchlistState();
}

class _StockWatchlistState extends State<StockWatchlist> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [Color(0x33FF0000), Color(0x33A5D6A7)],
          ),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          itemCount: testingList.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(
              testingList[index].ticker,
              style: TextStyle(
                  color: testingList[index].dayChangeDollars > 0
                      ? const Color(0xFF7FFF00)
                      : const Color(0xFFFF0000),
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ));
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.black,
            );
          },
        ));
  }
}
