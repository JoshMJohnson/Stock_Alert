import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_entity.dart';

/* handles database interations */
class DatabaseRepository {
  static Database? _db;
  static final DatabaseRepository instance = DatabaseRepository._constructor();
  final String stocksTable = 'stocks';

  DatabaseRepository._constructor();

  /* database getter function */
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  /* creates/retrieves database for stock watchlist */
  Future<Database> getDatabase() async {
    final dbDirPath = await getDatabasesPath();
    final dbPath = join(dbDirPath, 'stock_watchlist.db');
    final database = await openDatabase(
      dbPath,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $stocksTable(
          ticker TEXT PRIMARY KEY, companyName TEXT, companyDescription TEXT,
          tickerPrice REAL, dayChangeDollars REAL, dayChangePercentage REAL,
          exchange TEXT, low52Week REAL, high52Week REAL, activeTracking INTEGER DEFAULT 1
        )
        ''');
      },
      version: 1,
    );
    return database;
  }

  /* retrieves a list of all the watchlist stocks on the database  */
  Future<List<StockEntity>> getStockSymbols() async {
    final db = await database;
    final data = await db.query(stocksTable);

    List<StockEntity> stocks = data
        .map(
          (stock) => StockEntity(
            ticker: stock['ticker'] as String,
            companyName: stock['companyName'] as String,
            companyDescription: stock['companyDescription'] as String,
            tickerPrice: stock['tickerPrice'] as double,
            dayChangeDollars: stock['dayChangeDollars'] as double,
            dayChangePercentage: stock['dayChangePercentage'] as double,
            exchange: stock['exchange'] as String,
            low52Week: stock['low52Week'] as double,
            high52Week: stock['high52Week'] as double,
            activeTracking:
                (stock['activeTracking'] as int) == 1 ? true : false,
          ),
        )
        .toList();

    return stocks;
  }

  /* calls the twelve data API for a stock symbol and returns a Stock Entity with updated info */ // todo
  StockEntity retrieveStockDataFromTwelveDataAPI(String tickerSymbol) {
    debugPrint('****** api function... tickerSymbol: "$tickerSymbol"');

    StockEntity? updatedStockData = StockEntity(
      ticker: tickerSymbol,
      companyName: 'company name',
      companyDescription: 'company description',
      tickerPrice: 78.21,
      dayChangeDollars: 3.2,
      dayChangePercentage: 0.12,
      exchange: 'NASDAQ example',
      low52Week: 45.34,
      high52Week: 112.03,
      activeTracking: true,
    ); // ! find within database first; return null if new stock being added

    return updatedStockData;
  }

  /* adds a stock symbol to the watchlist */
  void addSymbol(String stockSymbol) async {
    StockEntity addingStock = retrieveStockDataFromTwelveDataAPI(stockSymbol);

    final db = await database;
    await db.insert(stocksTable, {
      'ticker': stockSymbol,
      'companyName': addingStock.companyName,
      'companyDescription': addingStock.companyDescription,
      'tickerPrice': addingStock.tickerPrice,
      'dayChangeDollars': addingStock.dayChangeDollars,
      'dayChangePercentage': addingStock.dayChangePercentage,
      'exchange': addingStock.exchange,
      'low52Week': addingStock.low52Week,
      'high52Week': addingStock.high52Week,
      'activeTracking': addingStock.activeTracking ? 1 : 0,
    });
  }

  /* updates the stock toggle within the database */
  void updateStockToggle(String tickerSymbol, bool toggleValue) async {
    final db = await database;
    await db.update(
      stocksTable,
      {'activeTracking': toggleValue},
      where: 'ticker = ?',
      whereArgs: [tickerSymbol],
    );
  }

  /* removes a stock symbol from the watchlist */
  void removeSymbol(String stockSymbol) async {
    // ! breaks; reload app, type an existing app and try to remove... nothing happens
    debugPrint('******* db page... removingTicker: "$stockSymbol"');
    final db = await database;
    await db.delete(
      stocksTable,
      where: 'ticker = ?',
      whereArgs: [stockSymbol],
    );
  }

  /* routine update to stock data (ex: PPS/Day Change) */ // todo
  // void updateSymbolData() {}

  /* updates stock symbol toggle to receive updates */ // todo
  // void updateSymbolToggle(StockEntity tickerSymbol) {}

  /* clears the watchlist */ // todo
  // void clearWatchlist() async {
  // await stockDB.rawDelete('DELETE * FROM stocks');
  // }

  /* returns stock symbols on the watchlist */ // todo
  // Future<List<StockEntity>> getWatchlist() async {
  //   final List<Map<String, Object?>> stockMaps = await stockDB.query('stocks');

  //   return [
  //     for (final {
  //           'tickerSymbol': tickerSymbol as String,
  //           'companyName': companyName as String,
  //           'companyDescription': companyDescription as String,
  //           'tickerPrice': tickerPrice as double,
  //           'dayChangeDollars': dayChangeDollars as double,
  //           'dayChangePercentage': dayChangePercentage as double,
  //           'exchange': exchange as String,
  //           'low52Week': low52Week as double,
  //           'high52Week': high52Week as double,
  //           'activeTracking': activeTracking as int,
  //         } in stockMaps)
  //       StockEntity(
  //         tickerSymbol: tickerSymbol,
  //         companyName: companyName,
  //         companyDescription: companyDescription,
  //         tickerPrice: tickerPrice,
  //         dayChangeDollars: dayChangeDollars,
  //         dayChangePercentage: dayChangePercentage,
  //         exchange: exchange,
  //         low52Week: low52Week,
  //         high52Week: high52Week,
  //         activeTracking: (activeTracking == 0 ? false : true),
  //       )
  //   ];
  // }

  /* returns an updated watchlist sorted based on algorithm provided */ // todo
  // List<StockEntity> sortWatchlist(
  //     List<StockEntity> watchlist, String sortAlgorithm) {
  //   List<StockEntity> sortedWatchlist = [];
  //   return sortedWatchlist;
  // }
}
