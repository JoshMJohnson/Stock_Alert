import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  /* calls the twelve data API for a stock symbol and returns a Stock Entity with updated info */ // todo
  StockEntity retrieveStockDataFromTwelveDataAPI(String tickerSymbol) {
    StockEntity? updatedStockData = StockEntity(
      ticker: tickerSymbol,
      companyName: 'company name',
      companyDescription: 'company description',
      tickerPrice: 78.21,
      dayChangeDollars: -3.2,
      dayChangePercentage: -0.1,
      exchange: 'NASDAQ example',
      low52Week: 45.34,
      high52Week: 112.03,
      activeTracking: true,
    ); // ! find within database first; return null if new stock being added

    return updatedStockData;
  }

  /* updates all watchlist stock tickers data */ // todo trigger on notification time
  void updateWatchlist(List<StockEntity> prevWatchlist) async {
    /* update time stamp for last updated */
    TimeOfDay currentTime = TimeOfDay.now();

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('lastUpdatedHours', currentTime.hour);
    prefs.setInt('lastUpdatedMinutes', currentTime.minute);

    /* update all stock data on watchlist */
    List<StockEntity> prevWatchlist = await getStockSymbols();

    for (var i = 0; i < prevWatchlist.length; i++) {
      /* only perform 8 api requests per minute per Twelve Data API request limit */
      if (i % 8 == 0) {
        await Future.delayed(const Duration(seconds: 61));
      }

      StockEntity updatedStockEntity =
          retrieveStockDataFromTwelveDataAPI(prevWatchlist[i].ticker);

      final db = await database;
      await db.update(
        stocksTable,
        {
          'tickerPrice': updatedStockEntity.tickerPrice,
          'dayChangeDollars': updatedStockEntity.dayChangeDollars,
          'dayChangePercentage': updatedStockEntity.dayChangePercentage,
          'exchange': updatedStockEntity.exchange,
          'low52Week': updatedStockEntity.low52Week,
          'high52Week': updatedStockEntity.high52Week,
        },
        where: 'ticker = ?',
        whereArgs: [updatedStockEntity.ticker],
      );
    }
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
      {
        'activeTracking': toggleValue ? 1 : 0,
      },
      where: 'ticker = ?',
      whereArgs: [tickerSymbol],
    );
  }

  /* removes a stock symbol from the watchlist */
  void removeSymbol(String stockSymbol) async {
    final db = await database;
    await db.delete(
      stocksTable,
      where: 'ticker = ?',
      whereArgs: [stockSymbol],
    );
  }

  /* clears the watchlist; removes all from the stocks table from the database */
  void clearWatchlist() async {
    final db = await database;
    await db.rawDelete('DELETE FROM $stocksTable');
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
}
