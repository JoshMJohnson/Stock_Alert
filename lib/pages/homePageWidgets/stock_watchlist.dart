import 'package:flutter/material.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_entity.dart';

// ! begin of testing code
StockEntity stock1 = StockEntity(
    ticker: 'AAPL',
    companyName: 'Apple Inc.',
    tickerPrice: 168.8,
    dayChangeDollars: -1.8,
    dayChangePercentage: -0.8,
    exchange: 'NASDAQ');

StockEntity stock2 = StockEntity(
    ticker: 'MSFTF',
    companyName: 'Microsoft Corp.',
    tickerPrice: 411.08,
    dayChangeDollars: -2.08,
    dayChangePercentage: -0.08,
    exchange: 'NYSE');

StockEntity stock3 = StockEntity(
    ticker: 'SNDL',
    companyName: 'This is the Sundile company',
    tickerPrice: 189.00,
    dayChangeDollars: 43.00,
    dayChangePercentage: 10.00,
    exchange: 'NASDAQ');

StockEntity stock4 = StockEntity(
    ticker: 'SPOT',
    companyName: 'Spotify',
    tickerPrice: 4,
    dayChangeDollars: -17,
    dayChangePercentage: -13,
    exchange: 'NASDAQ');

StockEntity stock5 = StockEntity(
    ticker: 'OGI',
    companyName: 'Organic Company',
    tickerPrice: 4.90,
    dayChangeDollars: 4.90,
    dayChangePercentage: 4.90,
    exchange: 'NYSE');

StockEntity stock6 = StockEntity(
    ticker: 'ADBE',
    companyName: 'Adobe',
    tickerPrice: 120.20,
    dayChangeDollars: 10.10,
    dayChangePercentage: 10.10,
    exchange: 'NYSE');

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
          itemCount: testingList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: SizedBox(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      testingList[index].exchange,
                      style: TextStyle(
                          color: testingList[index].dayChangePercentage > 0
                              ? const Color(0xFF7FFF00)
                              : const Color(0xFFFF0000),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      testingList[index].companyName,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: testingList[index].dayChangeDollars > 0
                              ? const Color(0xFF7FFF00)
                              : const Color(0xFFFF0000),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              title: Text(
                testingList[index].ticker,
                style: TextStyle(
                    color: testingList[index].dayChangeDollars > 0
                        ? const Color(0xFF7FFF00)
                        : const Color(0xFFFF0000),
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    testingList[index].dayChangePercentage.toString(),
                    style: TextStyle(
                        color: testingList[index].dayChangePercentage > 0
                            ? const Color(0xFF7FFF00)
                            : const Color(0xFFFF0000),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    testingList[index].dayChangeDollars.toString(),
                    style: TextStyle(
                        color: testingList[index].dayChangeDollars > 0
                            ? const Color(0xFF7FFF00)
                            : const Color(0xFFFF0000),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.black,
            );
          },
        ));
  }
}
