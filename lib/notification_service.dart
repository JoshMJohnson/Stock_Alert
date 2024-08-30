import 'package:awesome_notifications/android_foreground_service.dart';
import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:stock_alert/database_repository.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'dart:isolate';
// import 'dart:ui';

class NotificationService {
  /* initializes local notifications */
  static Future init() async {
    await initializePorts();
    await channelCreation();
    await createListeners();
    await initializeService();
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('** onNotificationCreatedMethod');
  }

  /* triggers on notification displayed */
  @pragma("vm:entry-point")
  static Future onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // try {
    //   final SendPort? sendPort =
    //       IsolateNameServer.lookupPortByName('notificationPort');

    //   if (receivedNotification.id! >= 3 && receivedNotification.id! <= 18) {
    //     // DatabaseRepository.updateWatchlist();
    //     sendPort?.send('update');
    //   }

    //   // sendPort?.send('sent from ya hommie port side');
    // } catch (e) {
    //   debugPrint('** $e');
    // }

    debugPrint('** onNotificationDisplayedMethod');

    /* if scheduled notification; begin pulling data from watchlist */
    /* 18 = starting at 3, 5 days a week, 3 possible daily reminders */
    if (receivedNotification.id! >= 3 && receivedNotification.id! <= 18) {
      DatabaseRepository.updateWatchlist();
    }
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('** onDismissActionReceivedMethod');
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('** onActionReceivedMethod');
  }

  /* creates the receive port for notifications in the background */
  static Future initializePorts() async {
    // ReceivePort receivePort = ReceivePort();

    // bool result = IsolateNameServer.registerPortWithName(
    //     receivePort.sendPort, 'notificationPort');

    // debugPrint(
    //     '*** result: $result'); // !terminate app, reopen with icon, returns false

    // if (result) {
    //   debugPrint('*** port created successfully');
    //   receivePort.listen((dynamic data) {
    //     debugPrint('*** port data: $data');
    //     debugPrint('*** port: ${data.toString()}');

    //     if (data.toString() == 'update') {
    //       debugPrint('updating');
    //       DatabaseRepository.updateWatchlist();
    //     }
    //   }, onError: (e) {
    //     debugPrint('*** error: $e');
    //   });
    // }
  }

  /* creates the notification channels */
  static Future channelCreation() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          groupKey: 'foreground_service',
          channelKey: 'foreground_service',
          channelName: 'Foreground Service',
          channelDescription: 'Foreground service',
          icon: 'resource://drawable/foreground_service_icon',
          defaultPrivacy: NotificationPrivacy.Public,
          playSound: false,
          enableVibration: false,
          locked: true,
          importance: NotificationImportance.Max,
        ),
        NotificationChannel(
          groupKey: 'schedule_triggered',
          channelKey: 'schedule_triggered',
          channelName: 'Update Triggered (Required)',
          channelDescription: 'Necessary for notification handling',
          icon: 'resource://drawable/update_icon',
          importance: NotificationImportance.Max,
          playSound: false,
          enableVibration: false,
        ),
        NotificationChannel(
          groupKey: 'updating_stocks',
          channelKey: 'update_progression',
          channelName: 'Update Progression',
          channelDescription: 'Progression on pulling updated ticker data',
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
          icon: 'resource://drawable/bull_icon',
          defaultPrivacy: NotificationPrivacy.Public,
          importance: NotificationImportance.Max,
          playSound: true,
          enableVibration: true,
        ),
        NotificationChannel(
          groupKey: 'bear_stocks',
          channelKey: 'bear_channel',
          channelName: 'Bear Stocks',
          channelDescription: 'Provides alerts for stocks that are down.',
          icon: 'resource://drawable/bear_icon',
          defaultPrivacy: NotificationPrivacy.Public,
          importance: NotificationImportance.Max,
          playSound: true,
          enableVibration: true,
        ),
      ],
    );
  }

  /* creates the event listeners for the notifications */
  static Future createListeners() async {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
    );
  }

  /* checks device settings if notifications are allowed */
  static Future<bool> checkPermissions() async {
    return await AwesomeNotifications().isNotificationAllowed();
  }

  /* promps user request for permissions */
  static Future requestPermissions() async {
    return await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  /* initializes the background service */
  static Future<void> initializeService() async {
    debugPrint('initializeService');

    // final service = FlutterBackgroundService();

    // await service.configure(
    //   iosConfiguration: IosConfiguration(),
    //   androidConfiguration: AndroidConfiguration(
    //     autoStart: false,
    //     onStart: onStart,
    //     isForegroundMode: true,
    //     autoStartOnBoot: true,
    //     notificationChannelId: 'foreground_service',
    //     initialNotificationTitle: 'Stock Alert is active...',
    //     initialNotificationContent: '',
    //     foregroundServiceNotificationId: 1,
    //   ),
    // );
  }

  /* brings app from background to foreground */
  @pragma("vm:entry-point")
  // static onStart(ServiceInstance service) {
  //   debugPrint('onStart');

  //   AndroidForegroundService.startAndroidForegroundService(
  //     foregroundStartMode: ForegroundStartMode.stick,
  //     foregroundServiceType: ForegroundServiceType.none,
  //     content: NotificationContent(
  //       id: 1,
  //       channelKey: 'foreground_service',
  //       title: 'Stock Alert is active....................',
  //       category: NotificationCategory.Service,
  //       locked: true,
  //       autoDismissible: false,
  //       color: const Color.fromARGB(255, 70, 130, 180),
  //     ),
  //   );

  //   service.on('stopService').listen((event) {
  //     service.stopSelf();
  //     debugPrint('stopping service!!!!');
  //   });
  // }

  /* starts the foreground service */
  static startForegroundService() {
    debugPrint('startForegroundService');

    AndroidForegroundService.startAndroidForegroundService(
      foregroundStartMode: ForegroundStartMode.stick,
      foregroundServiceType: ForegroundServiceType.none,
      content: NotificationContent(
        id: 1,
        channelKey: 'foreground_service',
        title: 'Stock Alert is active...',
        category: NotificationCategory.Service,
        locked: true,
        autoDismissible: false,
        color: const Color.fromARGB(255, 70, 130, 180),
      ),
    );

    // final service = FlutterBackgroundService();
    // service.startService();
  }

  /* terminates the foreground service */
  static terminateForegroundService() {
    debugPrint('terminateForegroundService');

    AndroidForegroundService.stopForeground(1);

    // final service = FlutterBackgroundService();
    // service.invoke("stopService");
  }

  /* terminates all previous scheduled notifications */
  static terminateScheduledNotifications() {
    debugPrint('terminateScheduledNotifications');

    AwesomeNotifications().cancelAll();
  }

  /* creates scheduled notification */
  static notificationGenerator(
    String easternTimeZone,
    int notificationID,
    int weekdayValue,
    TimeOfDay tod,
  ) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationID,
        channelKey: 'schedule_triggered',
        color: const Color.fromARGB(255, 70, 130, 180),
        actionType: ActionType.SilentAction,
        category: NotificationCategory.Reminder,
        title: 'Updating watchlist',
        timeoutAfter: const Duration(seconds: 1),
      ),
      schedule: NotificationCalendar(
        preciseAlarm: true,
        timeZone: easternTimeZone,
        allowWhileIdle: true,
        repeats: true,
        hour: tod.hour,
        minute: tod.minute,
        second: 0,
        weekday: weekdayValue,
      ),
    );
  }

  /* 
    creates a progression notification for pulling 
    updated watchlist ticker data scheduled for a specific time 
  */
  static createScheduledProgression(
    int quanitiyReminders,
    TimeOfDay notification1,
    TimeOfDay notification2,
    TimeOfDay notification3,
  ) async {
    debugPrint('createScheduledProgression');

    String easternTimeZone = 'America/New_York';

    int counterID = 3;
    int dayCounter = 1;

    /* scheduled daily reminder 1 */
    /* monday */
    notificationGenerator(
        easternTimeZone, counterID, dayCounter, notification1);
    counterID++;
    dayCounter++;

    // /* tuesday */
    notificationGenerator(
        easternTimeZone, counterID, dayCounter, notification1);
    counterID++;
    dayCounter++;

    // /* wednesday */
    notificationGenerator(
        easternTimeZone, counterID, dayCounter, notification1);
    counterID++;
    dayCounter++;

    // /* thursday */
    notificationGenerator(
        easternTimeZone, counterID, dayCounter, notification1);
    counterID++;
    dayCounter++;

    // /* friday */
    notificationGenerator(
        easternTimeZone, counterID, dayCounter, notification1);
    counterID++;
    dayCounter = 1;

    // ! testing start
    notificationGenerator(easternTimeZone, counterID, 6, notification1);
    counterID++;
    notificationGenerator(easternTimeZone, counterID, 7, notification1);
    counterID++;
    // ! testing end

    /* scheduled daily reminder 2 */
    if (quanitiyReminders >= 2) {
      /* monday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification2);
      counterID++;
      dayCounter++;

      // /* tuesday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification2);
      counterID++;
      dayCounter++;

      // /* wednesday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification2);
      counterID++;
      dayCounter++;

      // /* thursday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification2);
      counterID++;
      dayCounter++;

      // /* friday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification2);
      counterID++;
      dayCounter = 1;
    }

    /* scheduled daily reminder 3 */
    if (quanitiyReminders == 3) {
      /* monday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification3);
      counterID++;
      dayCounter++;

      // /* tuesday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification3);
      counterID++;
      dayCounter++;

      // /* wednesday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification3);
      counterID++;
      dayCounter++;

      // /* thursday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification3);
      counterID++;
      dayCounter++;

      // /* friday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification3);
    }
  }

  /* updates the current progress bar */
  static void updateProgressBar(
      int notificationID, int currentProgress, int totalTickersPulling) async {
    double progress = currentProgress / totalTickersPulling * 100;
    int estimatedMinsRemaining =
        ((totalTickersPulling - currentProgress) / 8).ceil();

    /* still pulling; reached api limit; delaying */
    if (currentProgress < totalTickersPulling) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: notificationID,
        channelKey: 'update_progression',
        title: 'Updating watchlist (${progress.round()}%)',
        body: estimatedMinsRemaining == 1
            ? 'Less than a minute remaining'
            : 'Estimated time remaining: $estimatedMinsRemaining mins.',
        autoDismissible: false,
        color: const Color.fromARGB(255, 70, 130, 180),
        notificationLayout: NotificationLayout.ProgressBar,
        category: NotificationCategory.Progress,
        progress: progress,
        locked: true,
      ));
    } else if (currentProgress == totalTickersPulling) {
      /* finished pulling ticker data from watchlist */
      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: notificationID,
        channelKey: 'update_progression',
        title: 'Watchlist updated',
        body: 'Finished gathering watchlist data',
        autoDismissible: true,
        color: const Color.fromARGB(255, 70, 130, 180),
        category: NotificationCategory.Progress,
        locked: false,
      ));
    } else {
      /* connection lost and could not get back */
      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: notificationID,
        channelKey: 'update_progression',
        title: 'Watchlist update failed',
        body: 'Internet connection was lost',
        autoDismissible: true,
        color: const Color.fromARGB(255, 70, 130, 180),
        category: NotificationCategory.Progress,
        locked: false,
      ));
    }
  }

  /* creates bear and bull display text notifications */
  static createBearBullNotifications(List<StockEntity> bullTickerList,
      List<StockEntity> bearTickerList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int notificationId = prefs.getInt('bearBullNotificationID') ?? 18;

    /* bull stock notification; stocks on watchlist that are up past the threshold value */
    if (bullTickerList.isNotEmpty) {
      String bullTickers = '';

      for (var tempTicker = 0;
          tempTicker < bullTickerList.length;
          tempTicker++) {
        String tempTickerSymbol = bullTickerList[tempTicker].ticker;
        String tempDayChange =
            bullTickerList[tempTicker].dayChangeDollars.toStringAsFixed(2);
        String tempPercentChange =
            bullTickerList[tempTicker].dayChangePercentage.toStringAsFixed(2);
        String tempPPS =
            bullTickerList[tempTicker].tickerPrice.toStringAsFixed(2);

        String tickerLine =
            '${Emojis.office_chart_increasing} $tempTickerSymbol \$$tempPPS (\$$tempDayChange) ($tempPercentChange%) ${Emojis.office_chart_increasing}';

        /* if last ticker in list of bull stocks given */
        if (tempTicker == bullTickerList.length - 1) {
          bullTickers = '$bullTickers$tickerLine';
          break;
        }

        bullTickers = '$bullTickers$tickerLine\n';
      }

      notificationId++;

      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: notificationId,
        channelKey: 'bull_channel',
        title: 'Bull Stocks',
        body: bullTickers,
        autoDismissible: false,
        notificationLayout: NotificationLayout.Inbox,
        color: const Color.fromARGB(255, 22, 129, 24),
        wakeUpScreen: true,
      ));
    }

    /* bear stock notification; stocks on watchlist that are down past the threshold value */
    if (bearTickerList.isNotEmpty) {
      String bearTickers = '';

      for (var tempTicker = 0;
          tempTicker < bearTickerList.length;
          tempTicker++) {
        String tempTickerSymbol = bearTickerList[tempTicker].ticker;
        String tempDayChange = bearTickerList[tempTicker]
            .dayChangeDollars
            .abs()
            .toStringAsFixed(2);
        String tempPercentChange = bearTickerList[tempTicker]
            .dayChangePercentage
            .abs()
            .toStringAsFixed(2);
        String tempPPS =
            bearTickerList[tempTicker].tickerPrice.toStringAsFixed(2);

        String tickerLine =
            '${Emojis.office_chart_decreasing} $tempTickerSymbol \$$tempPPS (-\$$tempDayChange) (-$tempPercentChange%) ${Emojis.office_chart_decreasing}';

        /* if last ticker in list of bull stocks given */
        if (tempTicker == bearTickerList.length - 1) {
          bearTickers = '$bearTickers$tickerLine';
          break;
        }

        bearTickers = '$bearTickers$tickerLine\n';
      }

      notificationId++;

      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: notificationId,
        channelKey: 'bear_channel',
        title: 'Bear Stocks',
        body: bearTickers,
        autoDismissible: false,
        notificationLayout: NotificationLayout.Inbox,
        color: const Color.fromARGB(255, 255, 0, 0),
        wakeUpScreen: true,
      ));
    }

    prefs.setInt('bearBullNotificationID', notificationId);
  }
}
