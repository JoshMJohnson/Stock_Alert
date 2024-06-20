import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_alert/notification_service.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_entity.dart';

import 'pages/home.dart';
import './theme.dart';
import 'package:stock_alert/database_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // * local notifications
  // todo
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        groupKey: 'updating_stocks',
        channelKey: 'update_progression',
        channelName: 'Update Progression',
        channelDescription: 'Progression on pulling updated ticker data',
        channelShowBadge: false,
        icon: 'resource://drawable/update_icon',
        importance: NotificationImportance.Low,
        playSound: false,
        enableVibration: false,
      ),
      NotificationChannel(
        groupKey: 'bull_stocks',
        channelKey: 'bull_channel',
        channelName: 'Bull Stocks',
        channelDescription: 'Provides alerts for stocks that are up.',
        channelShowBadge: false,
        icon: 'resource://drawable/bull_icon',
        importance: NotificationImportance.Default,
        playSound: true,
        enableVibration: true,
      ),
      NotificationChannel(
        groupKey: 'bear_stocks',
        channelKey: 'bear_channel',
        channelName: 'Bear Stocks',
        channelDescription: 'Provides alerts for stocks that are down.',
        channelShowBadge: false,
        icon: 'resource://drawable/bear_icon',
        importance: NotificationImportance.Default,
        playSound: true,
        enableVibration: true,
      ),
    ],
  );

  AwesomeNotifications().setListeners(
    onActionReceivedMethod: NotificationService.onActionReceivedMethod,
    onDismissActionReceivedMethod:
        NotificationService.onDismissActionReceivedMethod,
    onNotificationDisplayedMethod:
        NotificationService.onNotificationDisplayedMethod,
    onNotificationCreatedMethod:
        NotificationService.onNotificationCreatedMethod,
  );

  // * preferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  /* loads settings from device preferences */
  final String startupSortAlgorithm =
      prefs.getString('watchlistSort') ?? 'Alphabetically';

  final bool startupNotificationToggledOn =
      prefs.getBool('notificationToggle') ?? false;
  final double startupThresholdValue = prefs.getDouble('thresholdValue') ?? 5.0;
  final int startupNotificationQuantity =
      prefs.getInt('notificationQuantity') ?? 3;

  /* loads daily reminder settings */
  final int tod1Hours = prefs.getInt('tod1Hours') ?? 8;
  final int tod2Hours = prefs.getInt('tod2Hours') ?? 12;
  final int tod3Hours = prefs.getInt('tod3Hours') ?? 14;

  final int tod1Minutes = prefs.getInt('tod1Minutes') ?? 45;
  final int tod2Minutes = prefs.getInt('tod2Minutes') ?? 0;
  final int tod3Minutes = prefs.getInt('tod3Minutes') ?? 15;

  final TimeOfDay startupNotification1 =
      TimeOfDay(hour: tod1Hours, minute: tod1Minutes);
  final TimeOfDay startupNotification2 =
      TimeOfDay(hour: tod2Hours, minute: tod2Minutes);
  final TimeOfDay startupNotification3 =
      TimeOfDay(hour: tod3Hours, minute: tod3Minutes);

  // * database
  final DatabaseRepository repo = DatabaseRepository.instance;
  List<StockEntity> watchlist = await repo.getStockSymbols();

  runApp(MyApp(
    startupSortAlgorithm,
    startupNotificationToggledOn,
    startupThresholdValue,
    startupNotificationQuantity,
    startupNotification1,
    startupNotification2,
    startupNotification3,
    watchlist,
  ));
}

class MyApp extends StatelessWidget {
  final String startupSortAlgorithm;
  final bool startupNotificationToggledOn;
  final double startupThresholdValue;
  final int startupNotificationQuantity;
  final TimeOfDay startupNotification1;
  final TimeOfDay startupNotification2;
  final TimeOfDay startupNotification3;
  final List<StockEntity> watchlist;

  const MyApp(
      this.startupSortAlgorithm,
      this.startupNotificationToggledOn,
      this.startupThresholdValue,
      this.startupNotificationQuantity,
      this.startupNotification1,
      this.startupNotification2,
      this.startupNotification3,
      this.watchlist,
      {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      home: HomePage(
        startupSortAlgorithm,
        startupNotificationToggledOn,
        startupThresholdValue,
        startupNotificationQuantity,
        startupNotification1,
        startupNotification2,
        startupNotification3,
        watchlist,
      ),
    );
  }
}
