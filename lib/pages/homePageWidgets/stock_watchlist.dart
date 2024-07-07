import 'package:flutter/material.dart';

import 'package:stock_alert/pages/homePageWidgets/stock_entity.dart';
import '../ticker.dart';

class StockWatchlist extends StatelessWidget {
  final Function() updateWatchlistData;
  final Function(String) removeTicker;
  final Function(String, bool) updateActiveTracking;
  final List<StockEntity> watchlist;

  const StockWatchlist(this.updateWatchlistData, this.removeTicker,
      this.updateActiveTracking, this.watchlist,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
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
                      builder: (context) =>
                          TickerPage(removeTicker, watchlist[index]),
                    )).then((_) => updateWatchlistData());
              },
              leading: Switch(
                activeColor: const Color(0xFFA5D6A7),
                activeTrackColor: Colors.black,
                inactiveThumbColor: const Color(0xFFF44336),
                inactiveTrackColor: Colors.black,
                trackOutlineColor: MaterialStateProperty.resolveWith(
                  (final Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return const Color(0xFF388E3C);
                    }

                    return const Color(0xFFD32F2F);
                  },
                ),
                value: watchlist[index].activeTracking,
                onChanged: (bool updatedSwitchValue) => updateActiveTracking(
                    watchlist[index].ticker, updatedSwitchValue),
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
                          textScaler: TextScaler.noScaling,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          watchlist[index].companyName,
                          textScaler: TextScaler.noScaling,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Theme.of(context).colorScheme.tertiary,
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    watchlist[index].tickerPrice.toStringAsFixed(2),
                    textScaler: TextScaler.noScaling,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
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
                      '${watchlist[index].dayChangePercentage.toStringAsFixed(2)} (%)',
                      textScaler: TextScaler.noScaling,
                      style: TextStyle(
                          color: watchlist[index].dayChangePercentage >= 0
                              ? Theme.of(context).textTheme.bodyLarge!.color
                              : Theme.of(context).textTheme.bodySmall!.color,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${watchlist[index].dayChangeDollars.toStringAsFixed(2)}  (\$)',
                      textScaler: TextScaler.noScaling,
                      style: TextStyle(
                          color: watchlist[index].dayChangeDollars >= 0
                              ? Theme.of(context).textTheme.bodyLarge!.color
                              : Theme.of(context).textTheme.bodySmall!.color,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Theme.of(context).dividerColor,
            );
          },
        ));
  }
}
