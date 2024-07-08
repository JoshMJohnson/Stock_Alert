import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
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

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final tickerTextController = TextEditingController();

  /* home page variables */
  String currentTicker = '';
  List<StockEntity> watchlist;

  /* settings variables used for quick load time for settings page */
  String sortAlgorithm;
  bool notificationToggledOn;
  double thresholdValue;
  int notificationQuantity;
  TimeOfDay notification1;
  TimeOfDay notification2;
  TimeOfDay notification3;

  String lastUpdatedTimeDateDisplay = '--/-- --:--';

  final HelperFunctions helperFunctions = HelperFunctions();

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

  @override
  void initState() {
    loadLastUpdatedTime();
    updateWatchlistData();

    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    /* if bringing app into foreground focus from background */
    if (state == AppLifecycleState.resumed) {
      refreshHomePage();
    }
  }

  void loadLastUpdatedTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    /* last updated time stamp */
    final int? lastUpdatedHours = prefs.getInt('lastUpdatedHours');
    final int? lastUpdatedMinutes = prefs.getInt('lastUpdatedMinutes');
    final int? lastUpdatedMonth = prefs.getInt('lastUpdatedMonth');
    final int? lastUpdatedDay = prefs.getInt('lastUpdatedDay');

    if (lastUpdatedHours != null &&
        lastUpdatedMinutes != null &&
        lastUpdatedMonth != null &&
        lastUpdatedDay != null) {
      TimeOfDay lastUpdatedTime = TimeOfDay(
        hour: lastUpdatedHours,
        minute: lastUpdatedMinutes,
      );

      lastUpdatedTimeDateDisplay =
          helperFunctions.createDateDisplay(lastUpdatedMonth, lastUpdatedDay);

      lastUpdatedTimeDateDisplay += ' ';

      lastUpdatedTimeDateDisplay +=
          helperFunctions.standardTimeConvertionHandler(lastUpdatedTime);
    }
  }

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

    updateWatchlistData();
  }

  /* handles stock ticker text field change in value */
  void tickerFieldHandler(String updatedTickerValue) {
    setState(() {
      currentTicker = updatedTickerValue;
    });
  }

  /* updates active tracking toggle for stock entity */
  updateActiveTracking(String tickerSymbol, bool updatedActiveTracking) {
    DatabaseRepository.updateStockToggle(tickerSymbol, updatedActiveTracking);
    updateWatchlistData();
  }

  /* returns the string corresponding with the api error code */
  String apiErrorMessage(int errorCode) {
    if (errorCode == 400) {
      /* bad request; ticker went bankrupt */
      return 'Bad Request';
    } else if (errorCode == 401) {
      /* bad API key */
      return 'Bad/Incorrect Twelve Data API key';
    } else if (errorCode == 403) {
      /* upgraded twelve data plan needed */
      return 'Not available with the free version of Twelve Data API';
    } else if (errorCode == 404) {
      /* ticker not found */
      return 'Ticker not found on stock market';
    } else if (errorCode == 429) {
      /* too many requests */
      return 'Too many requests too fast. Wait a few seconds and try again';
    } else if (errorCode == 500) {
      /* tweleve data having issues; try again later message needed */
      return 'Twelve Data API is having server side issues. Try again later';
    } else if (errorCode == 1) {
      /* no internet connection */
      return 'No internet connection';
    } else {
      /* unknown error with twelve data api */
      return 'Unknown error with Twelve Data API';
    }
  }

  /* creates and displays alert for an error with the api */
  void errorAlertWithAPI(int errorCode) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
        title: Text(
          'Failed Add',
          textScaler: TextScaler.noScaling,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).textTheme.headlineMedium!.color,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).textTheme.headlineMedium!.color!,
                  width: 5,
                ),
              ),
              child: Text(
                currentTicker,
                textScaler: TextScaler.noScaling,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                apiErrorMessage(errorCode),
                textScaler: TextScaler.noScaling,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.cancel_outlined,
                  size: 55,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* handles adding ticker from text field to watchlist */
  void addTicker() async {
    int? errorCode = await DatabaseRepository.addSymbol(currentTicker);
    if (errorCode == 400) {
      /* bad request; ticker went bankrupt */
      errorAlertWithAPI(400);
    } else if (errorCode == 401) {
      /* bad API key */
      errorAlertWithAPI(401);
    } else if (errorCode == 403) {
      /* upgraded twelve data plan needed */
      errorAlertWithAPI(403);
    } else if (errorCode == 404) {
      /* ticker not found */
      errorAlertWithAPI(404);
    } else if (errorCode == 429) {
      /* too many requests */
      errorAlertWithAPI(429);
    } else if (errorCode == 500) {
      /* tweleve data having issues; try again later message needed */
      errorAlertWithAPI(500);
    } else if (errorCode == 501) {
      /* unknown error with twelve data api */
      errorAlertWithAPI(501);
    } else if (errorCode == 1) {
      /* no internet connection */
      errorAlertWithAPI(1);
    } else {
      updateWatchlistData();
    }
  }

  /* handles removing ticker from text field to watchlist */
  void removeTicker(String removingTicker) {
    DatabaseRepository.removeSymbol(removingTicker);
    updateWatchlistData();
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

  /* refreshes the stock watchlist display based on sort algorithm selected */
  void updateWatchlistSortAlgorithm() {
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
    FocusManager.instance.primaryFocus?.unfocus(); // close keyboard visibility
    tickerTextController.clear();

    watchlist = await DatabaseRepository.getStockSymbols();

    setState(() {
      watchlist = watchlist;
      currentTicker = '';
    });
  }

  /* refresh watchlist and last updated after notification triggered */
  void refreshHomePage() async {
    /* refresh 'Last Updated' display */
    loadLastUpdatedTime();

    /* refresh watchlist display */
    updateWatchlistData();
  }

  /* show info dialog */
  void showInfoDialog() {
    /* setup steps */
    String section1Header = 'Setup';
    String section1Body = 'Turn off battery optimization\n\n'
        'Device Settings -> Apps -> Stock Alert -> Battery -> Unrestricted';

    /* possible delays */
    String section2Header = 'Possible Delays';
    String section2Body =
        'Stock Alert uses Twelve Data API to access the stock market which has '
        'a limit of 8 ticker symbol lookups per minute.\n\n'
        'The limit may be encountered while adding stocks to the watchlist '
        'at the same time as collecting data for a notification.\n\n'
        'Notifications will also be delayed 1 minute for every 8 stocks on your watchlist.';

    /* holiday notification deliveries when market is closed */
    String section3Header = 'Holiday Exceptions';
    String section3Body =
        'Occasional holidays may not be registered for a closed market by Twelve Data API '
        'and may trigger a notification containing data from the last closing bell.';

    /* isActive ticker toggle on watchlist */
    String section4Header = 'Ticker Tracking';
    String section4Body =
        'The switch on the left side of each stock on the watchlist '
        'determines if that ticker symbol will be included in the bear/bull notifications '
        '(i.e. Turns on/off alerts for that ticker specifically).';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
        title: Text(
          'Quick Info',
          textScaler: TextScaler.noScaling,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).textTheme.headlineMedium!.color,
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
        content: FadingEdgeScrollView.fromSingleChildScrollView(
          gradientFractionOnEnd: .9,
          child: SingleChildScrollView(
            controller: ScrollController(
              initialScrollOffset: 0.0,
              keepScrollOffset: false,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: (Theme.of(context).cardTheme.color)!,
                      ),
                    ),
                  ),
                  child: Text(
                    section1Header,
                    textScaler: TextScaler.noScaling,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    section1Body,
                    textScaler: TextScaler.noScaling,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: (Theme.of(context).cardTheme.color)!,
                      ),
                    ),
                  ),
                  child: Text(
                    section2Header,
                    textScaler: TextScaler.noScaling,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    section2Body,
                    textScaler: TextScaler.noScaling,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: (Theme.of(context).cardTheme.color)!,
                      ),
                    ),
                  ),
                  child: Text(
                    section3Header,
                    textScaler: TextScaler.noScaling,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    section3Body,
                    textScaler: TextScaler.noScaling,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: (Theme.of(context).cardTheme.color)!,
                      ),
                    ),
                  ),
                  child: Text(
                    section4Header,
                    textScaler: TextScaler.noScaling,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    section4Body,
                    textScaler: TextScaler.noScaling,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.cancel_outlined,
                    size: 55,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
        leading: IconButton(
          onPressed: showInfoDialog,
          icon: Icon(
            Icons.info_outline,
            size: 40,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        title: Text(
          'Stock Alert',
          textScaler: TextScaler.noScaling,
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

  /* body widget of home page */
  Container homeBody(BuildContext context) {
    updateWatchlistSortAlgorithm();

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
              tickerTextController,
              watchlist,
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
              updateWatchlistData,
              removeTicker,
              updateActiveTracking,
              watchlist,
            ),
          ),
          Text(
            'Last Updated: $lastUpdatedTimeDateDisplay',
            textScaler: TextScaler.noScaling,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium!.color,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          )
        ]),
      ),
    );
  }
}
