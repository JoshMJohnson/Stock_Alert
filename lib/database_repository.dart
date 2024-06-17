import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_entity.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

/* handles database interations */
class DatabaseRepository {
  static Database? _db;
  static final DatabaseRepository instance = DatabaseRepository._constructor();
  final String stocksTable = 'stocks';
  final String apiCode =
      'b621e679c4744860a830188951a1a427'; /* Twelve Data API currently */

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
  Future retrieveStockDataFromTwelveDataAPI(
      String tickerSymbol, bool prevCreated) async {
    final tickerURL = Uri.parse(
        'https://api.twelvedata.com/quote?symbol=$tickerSymbol&apikey=$apiCode');
    final tickerData = await http.get(tickerURL);
    final tickerJSON = json.decode(tickerData.body) as Map<String, dynamic>;

    debugPrint(tickerData.body);

    /* assigns variable to the correct data */ // todo is_market_open
    String companyName = tickerJSON['name'];
    String companyDescription = 'Here is company description';
    double tickerPPS =
        double.parse(tickerJSON['open']) - double.parse(tickerJSON['change']);
    double dayChangeDollars = double.parse(tickerJSON['change']);
    double dayChangePercentage = double.parse(tickerJSON['percent_change']);
    String exchange = tickerJSON['exchange'];
    // double low52Week = double.parse(tickerJSON['fifty_two_week[low]']);
    // double high52Week = double.parse(tickerJSON['fifty_two_week[high]']);
    double low52Week = 5.4;
    double high52Week = 3.5;

    if (prevCreated) {
      final db = await database;
      await db.update(
        stocksTable,
        {
          'tickerPrice': tickerPPS,
          'dayChangeDollars': dayChangeDollars,
          'dayChangePercentage': dayChangePercentage,
          'low52Week': low52Week,
          'high52Week': high52Week,
        },
        where: 'ticker = ?',
        whereArgs: [tickerSymbol],
      );
    } else {
      final db = await database;
      await db.insert(
        stocksTable,
        {
          'ticker': tickerSymbol,
          'companyName': companyName,
          'companyDescription': companyDescription,
          'tickerPrice': tickerPPS,
          'dayChangeDollars': dayChangeDollars,
          'dayChangePercentage': dayChangePercentage,
          'exchange': exchange,
          'low52Week': low52Week,
          'high52Week': high52Week,
          'activeTracking': 1,
        },
      );
    }
  }

  /* updates all watchlist stock tickers data */ // todo trigger on notification time
  Future updateWatchlist(List<StockEntity> prevWatchlist) async {
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

      await retrieveStockDataFromTwelveDataAPI(prevWatchlist[i].ticker, true);
    }
  }

  /* adds a stock symbol to the watchlist */
  Future addSymbol(String stockSymbol) async {
    await retrieveStockDataFromTwelveDataAPI(stockSymbol, false);
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
