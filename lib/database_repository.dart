import 'dart:async';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:stock_alert/notification_service.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_entity.dart';

/* handles database interations */
class DatabaseRepository {
  static Database? _db;
  static final DatabaseRepository instance = DatabaseRepository._constructor();
  static const String stocksTable = 'stocks';
  static const String apiCode =
      '1a5736c710a640679295533e0c6a53ca'; /* Twelve Data API currently */
  static bool isMarketOpen = false;

  DatabaseRepository._constructor();

  /* database getter function */
  static Future<Database> get database async {
    return _db ??= await getDatabase();
  }

  /* creates/retrieves database for stock watchlist */
  static Future<Database> getDatabase() async {
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
  static Future retrieveStockDataFromTwelveDataAPI(String tickerSymbol) async {
    /* if error code 524; problem with Twelve Data API */
    Map<String, dynamic> tickerJSON;

    try {
      final tickerURL = Uri.parse(
          'https://api.twelvedata.com/quote?symbol=$tickerSymbol&apikey=$apiCode');
      final tickerData = await http.get(tickerURL);

      tickerJSON = json.decode(tickerData.body) as Map<String, dynamic>;
    } catch (e) {
      /* cannot connect to site */
      return 500;
    }

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
  static Future<List<StockEntity>> getBullStocks() async {
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

    /* sort notification ticker symbols */
    final String sortAlgorithm =
        prefs.getString('watchlistSort') ?? 'Alphabetically';

    if (sortAlgorithm == 'Alphabetically') {
      bullStocks.sort((a, b) => a.ticker.compareTo(b.ticker));
    } else if (sortAlgorithm == 'Ticker Price (PPS)') {
      bullStocks.sort((a, b) => b.tickerPrice.compareTo(a.tickerPrice));
    } else {
      bullStocks.sort(
          (a, b) => b.dayChangePercentage.compareTo(a.dayChangePercentage));
    }

    return bullStocks;
  }

  /* prepares a list of bear stocks according to the settings chosen */
  static Future<List<StockEntity>> getBearStocks() async {
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

    /* sort notification ticker symbols */
    final String sortAlgorithm =
        prefs.getString('watchlistSort') ?? 'Alphabetically';

    if (sortAlgorithm == 'Alphabetically') {
      bearStocks.sort((a, b) => a.ticker.compareTo(b.ticker));
    } else if (sortAlgorithm == 'Ticker Price (PPS)') {
      bearStocks.sort((a, b) => b.tickerPrice.compareTo(a.tickerPrice));
    } else {
      bearStocks.sort((a, b) =>
          b.dayChangePercentage.abs().compareTo(a.dayChangePercentage.abs()));
    }

    return bearStocks;
  }

  /* updates all watchlist stock tickers data */
  static Future updateWatchlist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int notificationID = prefs.getInt('bearBullNotificationID') ?? 6;
    notificationID++;

    /* update all stock data on watchlist */
    List<StockEntity> prevWatchlist = await getStockSymbols();
    int watchlistLength = prevWatchlist.length;
    int triedConnection = 0;

    /* loop through watchlist and update the data */
    for (int currentTickerIndex = 0;
        currentTickerIndex < watchlistLength;
        currentTickerIndex++) {
      String currentTickerSymbol = prevWatchlist[currentTickerIndex].ticker;
      int? errorCode;

      /* try to gather ticker data from the stock market */
      try {
        errorCode =
            await retrieveStockDataFromTwelveDataAPI(currentTickerSymbol);
      } catch (e) {
        if (triedConnection == 3) {
          /* if no internet connection */
          NotificationService.updateProgressBar(
            notificationID,
            currentTickerIndex,
            -1,
          );
          return;
        }

        /* show current progress when internet failed */
        NotificationService.updateProgressBar(
          notificationID,
          currentTickerIndex,
          watchlistLength,
        );

        currentTickerIndex--;

        if (triedConnection == 0 || triedConnection == 1) {
          /* if first 2 attempts */
          await Future.delayed(const Duration(minutes: 1));
        } else {
          /* if last attempt */
          await Future.delayed(const Duration(minutes: 5));
        }

        triedConnection++;
        continue;
      }

      /* if current ticker was removed or not found; remove ticker from watchlist */
      if (errorCode == 400 || errorCode == 404) {
        removeSymbol(prevWatchlist[currentTickerIndex].ticker);
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
      /* error with Twelve Data API site */
      else if (errorCode != null) {
        NotificationService.updateProgressBar(
          notificationID,
          currentTickerIndex,
          -2,
        );
        return;
      }
    }

    /* display finished pulling updated ticker data notification */
    NotificationService.updateProgressBar(
      notificationID,
      watchlistLength,
      watchlistLength,
    );

    prefs.setInt('bearBullNotificationID', notificationID);

    /* update time stamp for last updated */
    DateTime currentTime = DateTime.now();

    prefs.setInt('lastUpdatedHours', currentTime.hour);
    prefs.setInt('lastUpdatedMinutes', currentTime.minute);
    prefs.setInt('lastUpdatedMonth', currentTime.month);
    prefs.setInt('lastUpdatedDay', currentTime.day);

    /* gather bull and bear stocks that meet notification specs in settings */
    if (isMarketOpen) {
      List<StockEntity> bullStocks = await getBullStocks();
      List<StockEntity> bearStocks = await getBearStocks();
      NotificationService.createBearBullNotifications(bullStocks, bearStocks);
    }
    // ! testing start
    // else {
    //   List<StockEntity> bullStocks = await getBullStocks();
    //   List<StockEntity> bearStocks = await getBearStocks();
    //   NotificationService.createBearBullNotifications(bullStocks, bearStocks);
    // }
    // ! testing end
  }

  /* adds a stock symbol to the watchlist; gets data from twelve data api */
  static Future addSymbol(String tickerSymbol) async {
    dynamic tickerURL;
    dynamic tickerData;
    Map<String, dynamic> tickerJSON;

    try {
      tickerURL = Uri.parse(
          'https://api.twelvedata.com/quote?symbol=$tickerSymbol&apikey=$apiCode');
      tickerData = await http.get(tickerURL);
      tickerJSON = json.decode(tickerData.body) as Map<String, dynamic>;
    } catch (e) {
      /* cannot connect to site */
      return 1;
    }

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
    String companyDescription = 'Here is company description';
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
  }

  /* updates the stock toggle within the database */
  static void updateStockToggle(String tickerSymbol, bool toggleValue) async {
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
  static void removeSymbol(String stockSymbol) async {
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
  static Future<List<StockEntity>> getStockSymbols() async {
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
