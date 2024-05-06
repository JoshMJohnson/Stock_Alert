import 'package:flutter/material.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_entity.dart';

class StockWatchlist extends StatefulWidget {
  final String sortAlgorithm;
  final List<StockEntity> watchlist;
  const StockWatchlist(this.sortAlgorithm, this.watchlist, {super.key});

  @override
  State<StockWatchlist> createState() =>
      // ignore: no_logic_in_create_state
      _StockWatchlistState(sortAlgorithm, watchlist);
}

class _StockWatchlistState extends State<StockWatchlist> {
  final String sortAlgorithm;
  final List<StockEntity> watchlist;
  _StockWatchlistState(this.sortAlgorithm, this.watchlist);

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
              leading: SizedBox(
                width: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      watchlist[index].exchange,
                      style: TextStyle(
                          color: watchlist[index].dayChangePercentage > 0
                              ? const Color(0xFF7FFF00)
                              : const Color(0xFFFF0000),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      watchlist[index].companyName,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: watchlist[index].dayChangeDollars > 0
                              ? const Color(0xFF7FFF00)
                              : const Color(0xFFFF0000),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    watchlist[index].ticker,
                    style: TextStyle(
                        color: watchlist[index].dayChangeDollars > 0
                            ? const Color(0xFF7FFF00)
                            : const Color(0xFFFF0000),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    watchlist[index].tickerPrice.toStringAsFixed(2),
                    style: TextStyle(
                        color: watchlist[index].dayChangeDollars > 0
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
                          color: watchlist[index].dayChangePercentage > 0
                              ? const Color(0xFF7FFF00)
                              : const Color(0xFFFF0000),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${watchlist[index].dayChangeDollars.toStringAsFixed(2)}  (\$)',
                      style: TextStyle(
                          color: watchlist[index].dayChangeDollars > 0
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
