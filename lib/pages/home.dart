import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:stock_alert/helper_functions.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_watchlist.dart';
import 'package:stock_alert/pages/settings.dart';
import 'package:stock_alert/pages/homePageWidgets/ticker_input_fields.dart';
import 'package:stock_alert/pages/homePageWidgets/sort_input_fields.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_entity.dart';

class HomePage extends StatefulWidget {
  final bool startupLightMode;
  final String startupSortAlgorithm;
  final bool startupNotificationToggledOn;
  final double startupThresholdValue;
  final int startupNotificationQuantity;
  final TimeOfDay startupNotification1;
  final TimeOfDay startupNotification2;
  final TimeOfDay startupNotification3;

  const HomePage(
      this.startupLightMode,
      this.startupSortAlgorithm,
      this.startupNotificationToggledOn,
      this.startupThresholdValue,
      this.startupNotificationQuantity,
      this.startupNotification1,
      this.startupNotification2,
      this.startupNotification3,
      {super.key});

  @override
  State<HomePage> createState() =>
      // ignore: no_logic_in_create_state
      _HomePageState(
          startupLightMode,
          startupSortAlgorithm,
          startupNotificationToggledOn,
          startupThresholdValue,
          startupNotificationQuantity,
          startupNotification1,
          startupNotification2,
          startupNotification3);
}

class _HomePageState extends State<HomePage> {
  /* home page variables */
  bool lightMode;
  String currentTicker = '';
  late List<StockEntity> watchlist; // todo load from Firebase

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

  // ! begin of testing code
  final StockEntity stock1 = StockEntity(
      ticker: 'AAPLL',
      companyName: 'Apple Inc.',
      tickerPrice: 9999.8,
      dayChangeDollars: -111.80,
      dayChangePercentage: -10.80,
      exchange: 'ABC');

  final StockEntity stock2 = StockEntity(
      ticker: 'MSFTF',
      companyName: 'Microsoft Corp.',
      tickerPrice: 411.38,
      dayChangeDollars: -2.68,
      dayChangePercentage: -0.08,
      exchange: 'NYSE');

  final StockEntity stock3 = StockEntity(
      ticker: 'SNDL',
      companyName: 'This is the Sundile company',
      tickerPrice: 189.00,
      dayChangeDollars: 43.00,
      dayChangePercentage: 10.00,
      exchange: 'CBA');

  final StockEntity stock4 = StockEntity(
      ticker: 'SPOT',
      companyName: 'Spotify',
      tickerPrice: 4,
      dayChangeDollars: -17,
      dayChangePercentage: -13,
      exchange: 'NASDAQ');

  final StockEntity stock5 = StockEntity(
      ticker: 'OGI',
      companyName: 'Organic Company',
      tickerPrice: 4.90,
      dayChangeDollars: 4.90,
      dayChangePercentage: 4.90,
      exchange: 'NYSE');

  final StockEntity stock6 = StockEntity(
      ticker: 'ADBE',
      companyName: 'Adobe',
      tickerPrice: 120.20,
      dayChangeDollars: 10.10,
      dayChangePercentage: 10.10,
      exchange: 'NASDAQ');

  final StockEntity stock7 = StockEntity(
      ticker: 'BA',
      companyName: 'Boeing Co',
      tickerPrice: 170.42,
      dayChangeDollars: .2,
      dayChangePercentage: .11,
      exchange: 'NYSE');

  final StockEntity stock8 = StockEntity(
      ticker: 'BE',
      companyName: 'Bloom Energy Corp',
      tickerPrice: 9.52,
      dayChangeDollars: -.22,
      dayChangePercentage: -2.25,
      exchange: 'NYSE');

  final StockEntity stock9 = StockEntity(
      ticker: 'DIS',
      companyName: 'Walt Disney Co',
      tickerPrice: 112.31,
      dayChangeDollars: -.11,
      dayChangePercentage: -.09,
      exchange: 'NASDAQ');

  List<StockEntity> testingList = [];
  // ! end of testing code

  _HomePageState(
      this.lightMode,
      this.sortAlgorithm,
      this.notificationToggledOn,
      this.thresholdValue,
      this.notificationQuantity,
      this.notification1,
      this.notification2,
      this.notification3);

  /* changes the device setting for light/dark mode being active */
  lightDarkModeHandler() async {
    setState(() {
      lightMode = !lightMode;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('lightMode', lightMode);
  }

  /* executes when navigator pops Settings -> Home; updates preference variables */
  settingsToHomeHandler() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    notificationToggledOn = prefs.getBool('notificationToggle')!;
    thresholdValue = prefs.getDouble('thresholdValue')!;
    notificationQuantity = prefs.getInt('notificationQuantity')!;

    /* time of day preference variables */
    final int tod1Hours = prefs.getInt('tod1Hours')!;
    final int tod2Hours = prefs.getInt('tod2Hours')!;
    final int tod3Hours = prefs.getInt('tod3Hours')!;

    final int tod1Minutes = prefs.getInt('tod1Minutes')!;
    final int tod2Minutes = prefs.getInt('tod2Minutes')!;
    final int tod3Minutes = prefs.getInt('tod3Minutes')!;

    notification1 = TimeOfDay(hour: tod1Hours, minute: tod1Minutes);
    notification2 = TimeOfDay(hour: tod2Hours, minute: tod2Minutes);
    notification3 = TimeOfDay(hour: tod3Hours, minute: tod3Minutes);
  }

  /* updates active tracking toggle for stock entity */ // todo
  updateActiveTracking(bool updatedActiveTracking, StockEntity stock) {
    debugPrint('yessir... stock: ${stock.ticker}');
  }

  /* handles stock ticker text field change in value */
  void tickerFieldHandler(String updatedTickerValue) {
    setState(() {
      currentTicker = updatedTickerValue;
    });
  }

  /* handles adding ticker from text field to watchlist */ // todo
  void addTicker() {
    debugPrint(
        'Add stock ticker button pressed... currentTicker: $currentTicker');
  }

  /* handles removing ticker from text field to watchlist */ // todo
  void removeTicker() {
    debugPrint(
        'Remove stock ticker button pressed... currentTicker: $currentTicker');
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
  void updateWatchlistDisplaySortAlgorithm() {
    debugPrint('*********************Updating sort algorithm!');

    if (sortAlgorithm == 'Alphabetically') {
      testingList.sort((a, b) => a.ticker.compareTo(b.ticker));
    } else if (sortAlgorithm == 'Ticker Price') {
      testingList.sort((a, b) => b.tickerPrice.compareTo(a.tickerPrice));
    } else {
      testingList.sort(
          (a, b) => b.dayChangePercentage.compareTo(a.dayChangePercentage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context),
      body: homeBody(),
    );
  }

  /* header widget */
  AppBar header(BuildContext context) {
    return AppBar(
        leadingWidth: 110,
        title: Text(
          'Stock Alert',
          style: TextStyle(
              color: Colors.green[900],
              fontSize: 28,
              fontWeight: FontWeight.w900),
        ),
        leading: GestureDetector(
            onTap: lightDarkModeHandler,
            child: lightMode
                ? const Icon(Icons.dark_mode,
                    size: 40, color: Color(0xFFCC0000))
                : const Icon(Icons.light_mode,
                    size: 40, color: Color(0xFF7FFF00))),
        centerTitle: true,
        backgroundColor: Colors.green[200],
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
                                notification3)))
                    .then((_) => settingsToHomeHandler());
              },
              child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 35, 0),
                  child: Icon(
                    Icons.settings,
                    size: 40,
                    color: Colors.green[900],
                  ))),
        ]);
  }

  /* body widget of settings page */
  Container homeBody() {
    testingList = [
      stock1,
      stock2,
      stock3,
      stock4,
      stock5,
      stock6,
      stock7,
      stock8,
      stock9
    ];

    updateWatchlistDisplaySortAlgorithm(); // ! seems like the wrong location; called on text field typing

    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xAA006400), Color(0xFFA5D6A7)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                Image.asset(
                  'assets/bear_bull_fighting.png',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TickerInputFields(tickerFieldHandler, addTicker,
                      removeTicker, currentTicker),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: SortInputFields(sortChangeHandler, sortAlgorithm),
                ),
                Expanded(
                    child: StockWatchlist(updateActiveTracking, testingList)),
                Text(
                  'Last Updated: $lastUpdatedTimeDisplay',
                  style: const TextStyle(
                      color: Color(0xFFCC0000),
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                )
              ],
            )));
  }
}
