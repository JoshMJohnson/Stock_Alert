import 'package:flutter/material.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_entity.dart';

class DatabaseRepository {
  /* adds a stock symbol to the watchlist */ // todo
  void addSymbol() {}

  /* removes a stock symbol from the watchlist */ // todo
  void removeSymbol() {}

  /* routine update to stock data (ex: PPS/Day Change) */ // todo
  void updateSymbolData() {}

  /* updates stock symbol toggle to receive updates */ // todo
  void updateSymbolToggle(StockEntity tickerSymbol) {}

  /* clears the watchlist */ // todo
  void clearWatchlist() {}

  /* returns stock symbols on the watchlist */ // todo
  List<StockEntity> getWatchlist() {
    List<StockEntity> updatedWatchlist = [];
    return updatedWatchlist;
  }

  /* returns an updated watchlist sorted based on algorithm provided */ // todo
  List<StockEntity> sortWatchlist(
      List<StockEntity> watchlist, String sortAlgorithm) {
    List<StockEntity> sortedWatchlist = [];
    return sortedWatchlist;
  }
}
