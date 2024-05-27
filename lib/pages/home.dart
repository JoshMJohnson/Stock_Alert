import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:stock_alert/helper_functions.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_watchlist.dart';
import 'package:stock_alert/pages/settings.dart';
import 'package:stock_alert/pages/homePageWidgets/ticker_input_fields.dart';
import 'package:stock_alert/pages/homePageWidgets/sort_input_fields.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_entity.dart';
import 'package:stock_alert/database_repository.dart';

class HomePage extends StatefulWidget {
  final String startupSortAlgorithm;
  final bool startupNotificationToggledOn;
  final double startupThresholdValue;
  final int startupNotificationQuantity;
  final TimeOfDay startupNotification1;
  final TimeOfDay startupNotification2;
  final TimeOfDay startupNotification3;
  final List<StockEntity> watchlist;

  const HomePage(
      this.startupSortAlgorithm,
      this.startupNotificationToggledOn,
      this.startupThresholdValue,
      this.startupNotificationQuantity,
      this.startupNotification1,
      this.startupNotification2,
      this.startupNotification3,
      this.watchlist,
      {super.key});

  @override
  State<HomePage> createState() =>
      // ignore: no_logic_in_create_state
      _HomePageState(
        startupSortAlgorithm,
        startupNotificationToggledOn,
        startupThresholdValue,
        startupNotificationQuantity,
        startupNotification1,
        startupNotification2,
        startupNotification3,
        watchlist,
      );
}

class _HomePageState extends State<HomePage> {
  final DatabaseRepository repo = DatabaseRepository.instance;

  /* home page variables */
  String currentTicker = '';
  List<StockEntity> watchlist; // todo load from Firebase

  /* settings variables used for quick load time for settings page */
  String sortAlgorithm;
  bool notificationToggledOn;
  double thresholdValue;
  int notificationQuantity;
  TimeOfDay notification1;
  TimeOfDay notification2;
  TimeOfDay notification3;

  final HelperFunctions helperFunctions = HelperFunctions();

  TimeOfDay lastUpdatedTime =
      TimeOfDay.now(); // ! get last updated time rather than current time
  String lastUpdatedTimeDisplay = '';

  @override
  void initState() {
    lastUpdatedTimeDisplay =
        helperFunctions.standardTimeConvertionHandler(lastUpdatedTime);

    super.initState();
  }

  _HomePageState(
    this.sortAlgorithm,
    this.notificationToggledOn,
    this.thresholdValue,
    this.notificationQuantity,
    this.notification1,
    this.notification2,
    this.notification3,
    this.watchlist,
  );

  /* executes when navigator pops Settings -> Home; updates preference variables */
  settingsToHomeHandler() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    notificationToggledOn = prefs.getBool('notificationToggle') ?? false;
    thresholdValue = prefs.getDouble('thresholdValue') ?? 5.0;
    notificationQuantity = prefs.getInt('notificationQuantity') ?? 3;

    /* time of day preference variables */
    final int tod1Hours = prefs.getInt('tod1Hours') ?? 8;
    final int tod2Hours = prefs.getInt('tod2Hours') ?? 12;
    final int tod3Hours = prefs.getInt('tod3Hours') ?? 14;

    final int tod1Minutes = prefs.getInt('tod1Minutes') ?? 45;
    final int tod2Minutes = prefs.getInt('tod2Minutes') ?? 0;
    final int tod3Minutes = prefs.getInt('tod3Minutes') ?? 12;

    notification1 = TimeOfDay(hour: tod1Hours, minute: tod1Minutes);
    notification2 = TimeOfDay(hour: tod2Hours, minute: tod2Minutes);
    notification3 = TimeOfDay(hour: tod3Hours, minute: tod3Minutes);
  }

  /* handles stock ticker text field change in value */
  void tickerFieldHandler(String updatedTickerValue) {
    setState(() {
      currentTicker = updatedTickerValue;
    });
  }

  /* updates active tracking toggle for stock entity */
  updateActiveTracking(String tickerSymbol, bool updatedActiveTracking) {
    repo.updateStockToggle(tickerSymbol, updatedActiveTracking);
    updateWatchlistData();
  }

  /* handles adding ticker from text field to watchlist */
  void addTicker() {
    debugPrint(
        'Add stock ticker button pressed... currentTicker: $currentTicker');

    repo.addSymbol(currentTicker);
    updateWatchlistData();
  }

  /* handles removing ticker from text field to watchlist */ // todo
  void removeTicker(String removingTicker) {
    debugPrint(
        'Remove stock ticker button pressed... currentTicker: $removingTicker');
  }

  /* handles the change in sort algorithm for stock watchlist */
  void sortChangeHandler() async {
    setState(() {
      if (sortAlgorithm == 'Alphabetically') {
        sortAlgorithm = 'Ticker Price';
      } else if (sortAlgorithm == 'Ticker Price') {
        sortAlgorithm = 'Day Change (%)';
      } else {
        sortAlgorithm = 'Alphabetically';
      }
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('watchlistSort', sortAlgorithm);
  }

  /* refreshes the stock watchlist display based on sort algorithm selected */ // todo
  void updateWatchlistSortAlgorithm() {
    debugPrint('*********************Updating sort algorithm!');

    if (sortAlgorithm == 'Alphabetically') {
      watchlist.sort((a, b) => a.ticker.compareTo(b.ticker));
    } else if (sortAlgorithm == 'Ticker Price') {
      watchlist.sort((a, b) => b.tickerPrice.compareTo(a.tickerPrice));
    } else {
      watchlist.sort(
          (a, b) => b.dayChangePercentage.compareTo(a.dayChangePercentage));
    }
  }

  /* updates the watchlist stock data */
  void updateWatchlistData() async {
    watchlist = await repo.getStockSymbols();

    setState(() {
      watchlist = watchlist;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context),
      body: homeBody(context),
    );
  }

  /* header widget */
  AppBar header(BuildContext context) {
    return AppBar(
        leadingWidth: 110,
        title: Text(
          'Stock Alert',
          style: TextStyle(
            color: Theme.of(context).textTheme.headlineMedium!.color,
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(
                    notificationToggledOn,
                    thresholdValue,
                    notificationQuantity,
                    notification1,
                    notification2,
                    notification3,
                  ),
                ),
              ).then((_) => settingsToHomeHandler());
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 35, 0),
              child: Icon(
                Icons.settings,
                size: 40,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
        ]);
  }

  /* body widget of settings page */
  Container homeBody(BuildContext context) {
    updateWatchlistSortAlgorithm(); // ! seems like the wrong location; called on text field typing

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).colorScheme.background
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(children: [
          Image.asset(
            'assets/bear_bull_fighting.png',
            width: double.infinity,
            height: 200,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: TickerInputFields(
              tickerFieldHandler,
              addTicker,
              removeTicker,
              currentTicker,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: SortInputFields(
              sortChangeHandler,
              sortAlgorithm,
            ),
          ),
          Expanded(
            child: StockWatchlist(
              removeTicker,
              updateActiveTracking,
              watchlist,
            ),
          ),
          Text(
            'Last Updated: $lastUpdatedTimeDisplay',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium!.color,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          )
        ]),
      ),
    );
  }
}
