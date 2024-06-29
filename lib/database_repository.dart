import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_alert/notification_service.dart';
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
  bool isMarketOpen = false;

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

  /* calls the twelve data API for a stock symbol and updates database row with updated info */
  Future retrieveStockDataFromTwelveDataAPI(String tickerSymbol) async {
    final tickerURL = Uri.parse(
        'https://api.twelvedata.com/quote?symbol=$tickerSymbol&apikey=$apiCode');
    final tickerData = await http.get(tickerURL);
    final tickerJSON = json.decode(tickerData.body) as Map<String, dynamic>;

    /* handles possible errors */
    var hasError = tickerJSON['code'] != null ? true : false;
    if (hasError) {
      var errorType = tickerJSON['code'];

      if (errorType == 400) {
        /* bad request; ticker went bankrupt */
        return 400;
      } else if (errorType == 401) {
        /* bad API key */
        return 401;
      } else if (errorType == 403) {
        /* upgraded twelve data plan needed */
        return 403;
      } else if (errorType == 404) {
        /* ticker not found */
        return 404;
      } else if (errorType == 429) {
        /* too many requests */
        return 429;
      } else if (errorType == 500) {
        /* tweleve data having issues; try again later message needed */
        return 500;
      }

      /* unknown error with Twelve Data API */
      return 501;
    }

    /* assigns variable to the correct data */
    double tickerPPS = double.parse(tickerJSON['previous_close']) +
        double.parse(tickerJSON['change']);
    double dayChangeDollars = double.parse(tickerJSON['change']);
    double dayChangePercentage = double.parse(tickerJSON['percent_change']);

    var weeks52 = tickerJSON['fifty_two_week'];
    double low52Week = double.parse(weeks52['low']);
    double high52Week = double.parse(weeks52['high']);

    isMarketOpen = tickerJSON['is_market_open'];

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
  }

  /* prepares a list of bull stocks according to the settings chosen */
  Future<List<StockEntity>> getBullStocks() async {
    List<StockEntity> allStocks = await getStockSymbols();
    List<StockEntity> bullStocks = [];

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double thresholdValue = prefs.getDouble('thresholdValue')!;

    /* loops through all watchlist tickers */
    for (var ticker = 0; ticker < allStocks.length; ticker++) {
      /* if active tracking is off for current ticker; advance in list */
      if (!allStocks[ticker].activeTracking) {
        continue;
      }

      /* if ticker is above the threshold set */
      if (allStocks[ticker].dayChangePercentage >= thresholdValue) {
        bullStocks.add(allStocks[ticker]);
      }
    }

    return bullStocks;
  }

  /* prepares a list of bear stocks according to the settings chosen */
  Future<List<StockEntity>> getBearStocks() async {
    List<StockEntity> allStocks = await getStockSymbols();
    List<StockEntity> bearStocks = [];

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double thresholdValue = prefs.getDouble('thresholdValue')!;

    /* loops through all watchlist tickers */
    for (var ticker = 0; ticker < allStocks.length; ticker++) {
      /* if active tracking is off for current ticker; advance in list */
      if (!allStocks[ticker].activeTracking) {
        continue;
      }

      /* if ticker is above the threshold set */
      if (allStocks[ticker].dayChangePercentage < 0 &&
          allStocks[ticker].dayChangePercentage.abs() > thresholdValue) {
        bearStocks.add(allStocks[ticker]);
      }
    }

    return bearStocks;
  }

  /* updates all watchlist stock tickers data */ // todo trigger on notification time
  Future updateWatchlist(int notificationID) async {
    debugPrint('************updateWatchlist*************'); // ! testing

    /* update time stamp for last updated */ // todo also pull date
    TimeOfDay currentTime = TimeOfDay.now();

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('lastUpdatedHours', currentTime.hour);
    prefs.setInt('lastUpdatedMinutes', currentTime.minute);

    /* update all stock data on watchlist */
    List<StockEntity> prevWatchlist = await getStockSymbols();
    int watchlistLength = prevWatchlist.length;

    /* loop through watchlist and update the data */
    for (var currentTickerIndex = 0;
        currentTickerIndex < watchlistLength;
        currentTickerIndex++) {
      String currentTickerSymbol = prevWatchlist[currentTickerIndex].ticker;

      int errorCode =
          await retrieveStockDataFromTwelveDataAPI(currentTickerSymbol);

      if (errorCode == 400 || errorCode == 404) {
        /* if current ticker was removed or not found; remove ticker from watchlist */ // todo
        debugPrint(
            '************Ticker Error; removing ticker from watchlist**************');
      }
      /* else; no errors occured finding ticker on the stock market; minute limit reached though */
      else if (errorCode == 429) {
        NotificationService.updateProgressBar(
          notificationID,
          currentTickerIndex,
          watchlistLength,
        );

        await Future.delayed(const Duration(seconds: 61));
        currentTickerIndex--; /* retry ticker that failed */
      }
    }

    /* display finished pulling updated ticker data notification */
    NotificationService.updateProgressBar(
      notificationID,
      watchlistLength,
      watchlistLength,
    );

    // todo update watchlist on Home Page

    /* gather bull and bear stocks that meet notification specs in settings */
    if (isMarketOpen) {
      // todo if stock market is closed... stop  pulling
      List<StockEntity> bullStocks = await getBullStocks();
      List<StockEntity> bearStocks = await getBearStocks();
      NotificationService.createBearBullNotifications(bullStocks, bearStocks);
    }

    // ! begin of testing
    List<StockEntity> bullStocks = await getBullStocks();
    List<StockEntity> bearStocks = await getBearStocks();
    NotificationService.createBearBullNotifications(bullStocks, bearStocks);
    // ! end of testing
  }

  /* adds a stock symbol to the watchlist; gets data from twelve data api */
  Future addSymbol(String tickerSymbol) async {
    final tickerURL = Uri.parse(
        'https://api.twelvedata.com/quote?symbol=$tickerSymbol&apikey=$apiCode');
    final tickerData = await http.get(tickerURL);
    final tickerJSON = json.decode(tickerData.body) as Map<String, dynamic>;

    /* handles possible errors */
    var hasError = tickerJSON['code'] != null ? true : false;
    if (hasError) {
      var errorType = tickerJSON['code'];

      if (errorType == 400) {
        /* bad request; ticker went bankrupt */
        return 400;
      } else if (errorType == 401) {
        /* bad API key */
        return 401;
      } else if (errorType == 403) {
        /* upgraded twelve data plan needed */
        return 403;
      } else if (errorType == 404) {
        /* ticker not found */
        return 404;
      } else if (errorType == 429) {
        /* too many requests */
        return 429;
      } else if (errorType == 500) {
        /* tweleve data having issues; try again later message needed */
        return 500;
      }

      /* unknown error with Twelve Data API */
      return 501;
    }

    /* assigns variable to the correct data */
    double tickerPPS = double.parse(tickerJSON['previous_close']) +
        double.parse(tickerJSON['change']);
    double dayChangeDollars = double.parse(tickerJSON['change']);
    double dayChangePercentage = double.parse(tickerJSON['percent_change']);

    var weeks52 = tickerJSON['fifty_two_week'];
    double low52Week = double.parse(weeks52['low']);
    double high52Week = double.parse(weeks52['high']);

    String companyName = tickerJSON['name'];
    String companyDescription = 'Here is company description'; // todo
    String exchange = tickerJSON['exchange'];

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

    return -1;
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
