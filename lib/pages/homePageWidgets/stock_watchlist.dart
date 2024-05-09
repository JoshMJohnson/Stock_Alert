import 'package:flutter/material.dart';

import 'package:stock_alert/pages/homePageWidgets/stock_entity.dart';
import '../ticker.dart';

class StockWatchlist extends StatelessWidget {
  final Function(bool, StockEntity) updateActiveTracking;
  final List<StockEntity> watchlist;
  const StockWatchlist(this.updateActiveTracking, this.watchlist, {super.key});

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
          itemCount: watchlist.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              dense: true,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TickerPage(watchlist[index])));
              },
              leading: SizedBox(
                width: 50,
                child: Switch(
                  value: false,
                  onChanged: (bool updatedSwitchValue) => updateActiveTracking(
                      updatedSwitchValue, watchlist[index]),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 115,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          watchlist[index].ticker,
                          style: TextStyle(
                              color: watchlist[index].dayChangePercentage >= 0
                                  ? const Color(0xFF7FFF00)
                                  : const Color(0xFFFF0000),
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          watchlist[index].companyName,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: watchlist[index].dayChangeDollars >= 0
                                  ? const Color(0xFF7FFF00)
                                  : const Color(0xFFFF0000),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    watchlist[index].tickerPrice.toStringAsFixed(2),
                    style: TextStyle(
                        color: watchlist[index].dayChangeDollars >= 0
                            ? const Color(0xFF7FFF00)
                            : const Color(0xFFFF0000),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              trailing: SizedBox(
                width: 75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${watchlist[index].dayChangePercentage} (%)',
                      style: TextStyle(
                          color: watchlist[index].dayChangePercentage >= 0
                              ? const Color(0xFF7FFF00)
                              : const Color(0xFFFF0000),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${watchlist[index].dayChangeDollars.toStringAsFixed(2)}  (\$)',
                      style: TextStyle(
                          color: watchlist[index].dayChangeDollars >= 0
                              ? const Color(0xFF7FFF00)
                              : const Color(0xFFFF0000),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Color(0xFF1B5E20),
            );
          },
        ));
  }
}
