import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:stock_alert/database_repository.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_notifications/android_foreground_service.dart';

/// Use this method to detect when a new notification or a schedule is created
@pragma("vm:entry-point")
Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification) async {}

/* triggers on notification displayed */
@pragma("vm:entry-point")
Future onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification) async {
  /* if scheduled notification; begin pulling data from watchlist */
  /* 18 = starting at 3, 5 days a week, 3 possible daily reminders */
  if (receivedNotification.id! >= 3 && receivedNotification.id! <= 18) {
    DatabaseRepository.updateWatchlist();
  }
}

/// Use this method to detect if the user dismissed a notification
@pragma("vm:entry-point")
Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction) async {}

/// Use this method to detect when the user taps on a notification or action button
@pragma("vm:entry-point")
Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {}

class NotificationService {
  @override
  void onRepeatEvent(DateTime timestamp) async {
    // String easternTimeZone = 'America/New_York';

    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // final int notificationQuantity = prefs.getInt('notificationQuantity') ?? 3;

    // int tod1Hours = prefs.getInt('tod1Hours')!;
    // int tod1Minutes = prefs.getInt('tod1Minutes')!;
    // int tod2Hours = prefs.getInt('tod2Hours')!;
    // int tod2Minutes = prefs.getInt('tod2Minutes')!;
    // int tod3Hours = prefs.getInt('tod3Hours')!;
    // int tod3Minutes = prefs.getInt('tod3Minutes')!;

    // TimeOfDay notification1TOD =
    //     TimeOfDay(hour: tod1Hours, minute: tod1Minutes);
    // TimeOfDay notification2TOD =
    //     TimeOfDay(hour: tod2Hours, minute: tod2Minutes);
    // TimeOfDay notification3TOD =
    //     TimeOfDay(hour: tod3Hours, minute: tod3Minutes);

    // int counterID = 3;
    // int dayCounter = 1;

    // /* scheduled daily reminder 1 */
    // /* monday */
    // notificationGenerator(
    //     easternTimeZone, counterID, dayCounter, notification1TOD);

    // counterID++;
    // dayCounter++;

    // /* tuesday */
    // notificationGenerator(
    //     easternTimeZone, counterID, dayCounter, notification1TOD);

    // counterID++;
    // dayCounter++;

    // /* wednesday */
    // notificationGenerator(
    //     easternTimeZone, counterID, dayCounter, notification1TOD);

    // counterID++;
    // dayCounter++;

    // /* thursday */
    // notificationGenerator(
    //     easternTimeZone, counterID, dayCounter, notification1TOD);

    // counterID++;
    // dayCounter++;

    // /* friday */
    // notificationGenerator(
    //     easternTimeZone, counterID, dayCounter, notification1TOD);

    // counterID++;
    // dayCounter++;

    // // ! testing start
    // // notificationGenerator(easternTimeZone, counterID, 6, notification1TOD);
    // // counterID++;
    // // notificationGenerator(easternTimeZone, counterID, 7, notification1TOD);
    // // counterID++;
    // // ! testing end

    // /* scheduled daily reminder 2 */
    // if (notificationQuantity >= 2) {
    //   int dayCounter = 1;

    //   /* monday */
    //   notificationGenerator(
    //       easternTimeZone, counterID, dayCounter, notification2TOD);

    //   counterID++;
    //   dayCounter++;

    //   /* tuesday */
    //   notificationGenerator(
    //       easternTimeZone, counterID, dayCounter, notification2TOD);

    //   counterID++;
    //   dayCounter++;

    //   /* wednesday */
    //   notificationGenerator(
    //       easternTimeZone, counterID, dayCounter, notification2TOD);

    //   counterID++;
    //   dayCounter++;

    //   /* thursday */
    //   notificationGenerator(
    //       easternTimeZone, counterID, dayCounter, notification2TOD);

    //   counterID++;
    //   dayCounter++;

    //   /* friday */
    //   notificationGenerator(
    //       easternTimeZone, counterID, dayCounter, notification2TOD);

    //   counterID++;
    //   dayCounter++;
    // }

    // /* scheduled daily reminder 2 */
    // if (notificationQuantity == 3) {
    //   int dayCounter = 1;

    //   /* monday */
    //   notificationGenerator(
    //       easternTimeZone, counterID, dayCounter, notification3TOD);

    //   counterID++;
    //   dayCounter++;

    //   /* tuesday */
    //   notificationGenerator(
    //       easternTimeZone, counterID, dayCounter, notification3TOD);

    //   counterID++;
    //   dayCounter++;

    //   /* wednesday */
    //   notificationGenerator(
    //       easternTimeZone, counterID, dayCounter, notification3TOD);

    //   counterID++;
    //   dayCounter++;

    //   /* thursday */
    //   notificationGenerator(
    //       easternTimeZone, counterID, dayCounter, notification3TOD);

    //   counterID++;
    //   dayCounter++;

    //   /* friday */
    //   notificationGenerator(
    //       easternTimeZone, counterID, dayCounter, notification3TOD);
    // }
  }

  /* initializes local notifications */
  static Future init() async {
    await channelCreation();
    await createListeners();
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

  /* creates the notification channels */
  static Future channelCreation() async {
    await AwesomeNotifications().initialize(
      'resource://drawable/foreground_service_icon',
      [
        NotificationChannel(
          groupKey: 'foreground_service',
          channelKey: 'foreground_service',
          channelName: 'Foreground Service',
          channelDescription: 'Foreground service',
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
          importance: NotificationImportance.Max,
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

  /* checks device settings if notifications are allowed */
  static Future<bool> checkPermissions() async {
    return await AwesomeNotifications().isNotificationAllowed();
  }

  /* promps user request for permissions */
  static Future requestPermissions() async {
    List<NotificationPermission> permissionList = [
      NotificationPermission.Badge,
      NotificationPermission.Alert,
      NotificationPermission.Sound,
      NotificationPermission.Vibration,
      NotificationPermission.Light,
      NotificationPermission.PreciseAlarms,
    ];

    // Check if the basic permission was granted by the user
    await AwesomeNotifications().requestPermissionToSendNotifications(
      permissions: permissionList,
    );
  }

  /* starts the foreground service */
  static startForegroundService() async {
    await AndroidForegroundService.startAndroidForegroundService(
      foregroundStartMode: ForegroundStartMode.stick,
      foregroundServiceType: ForegroundServiceType.dataSync,
      content: NotificationContent(
        id: 1,
        title: 'Stock Alert is active...',
        channelKey: 'foreground_service',
        category: NotificationCategory.Service,
      ),
    );
  }

  /* terminates the foreground service and terminates all previous scheduled notifications */
  static terminateForegroundService() async {
    await AwesomeNotifications().cancelAll();
    await AndroidForegroundService.stopForeground(1);
  }

  /* schedules the reminders when save was pressed within settings page */ // todo
  static scheduleReminders() async {
    String easternTimeZone = 'America/New_York';

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final int notificationQuantity = prefs.getInt('notificationQuantity') ?? 3;

    int tod1Hours = prefs.getInt('tod1Hours')!;
    int tod1Minutes = prefs.getInt('tod1Minutes')!;
    int tod2Hours = prefs.getInt('tod2Hours')!;
    int tod2Minutes = prefs.getInt('tod2Minutes')!;
    int tod3Hours = prefs.getInt('tod3Hours')!;
    int tod3Minutes = prefs.getInt('tod3Minutes')!;

    TimeOfDay notification1TOD =
        TimeOfDay(hour: tod1Hours, minute: tod1Minutes);
    TimeOfDay notification2TOD =
        TimeOfDay(hour: tod2Hours, minute: tod2Minutes);
    TimeOfDay notification3TOD =
        TimeOfDay(hour: tod3Hours, minute: tod3Minutes);

    int counterID = 3;
    int dayCounter = 1;

    /* scheduled daily reminder 1 */
    /* monday */
    notificationGenerator(
        easternTimeZone, counterID, dayCounter, notification1TOD);

    counterID++;
    dayCounter++;

    /* tuesday */
    notificationGenerator(
        easternTimeZone, counterID, dayCounter, notification1TOD);

    counterID++;
    dayCounter++;

    /* wednesday */
    notificationGenerator(
        easternTimeZone, counterID, dayCounter, notification1TOD);

    counterID++;
    dayCounter++;

    /* thursday */
    notificationGenerator(
        easternTimeZone, counterID, dayCounter, notification1TOD);

    counterID++;
    dayCounter++;

    /* friday */
    notificationGenerator(
        easternTimeZone, counterID, dayCounter, notification1TOD);

    counterID++;
    dayCounter++;

    // ! testing start
    notificationGenerator(easternTimeZone, counterID, 6, notification1TOD);
    counterID++;
    notificationGenerator(easternTimeZone, counterID, 7, notification1TOD);
    counterID++;
    // ! testing end

    /* scheduled daily reminder 2 */
    if (notificationQuantity >= 2) {
      int dayCounter = 1;

      /* monday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification2TOD);

      counterID++;
      dayCounter++;

      /* tuesday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification2TOD);

      counterID++;
      dayCounter++;

      /* wednesday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification2TOD);

      counterID++;
      dayCounter++;

      /* thursday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification2TOD);

      counterID++;
      dayCounter++;

      /* friday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification2TOD);

      counterID++;
      dayCounter++;
    }

    /* scheduled daily reminder 2 */
    if (notificationQuantity == 3) {
      int dayCounter = 1;

      /* monday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification3TOD);

      counterID++;
      dayCounter++;

      /* tuesday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification3TOD);

      counterID++;
      dayCounter++;

      /* wednesday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification3TOD);

      counterID++;
      dayCounter++;

      /* thursday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification3TOD);

      counterID++;
      dayCounter++;

      /* friday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification3TOD);
    }
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
        actionType: ActionType.Default,
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

  /* updates the current progress bar */
  static void updateProgressBar(
      int notificationID, int currentProgress, int totalTickersPulling) async {
    /* dismisses previous out-of-date notifications */
    await AwesomeNotifications().dismissAllNotifications();

    /* still pulling; reached api limit; delaying */
    if (currentProgress < totalTickersPulling) {
      double progress = currentProgress / totalTickersPulling * 100;
      int estimatedMinsRemaining =
          ((totalTickersPulling - currentProgress) / 8).ceil();

      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: notificationID,
        channelKey: 'update_progression',
        title: 'Updating Watchlist (${progress.round()}%)',
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
        title: 'Watchlist Updated',
        body: 'Successfully updated watchlist',
        autoDismissible: false,
        color: const Color.fromARGB(255, 70, 130, 180),
        category: NotificationCategory.Progress,
        locked: false,
      ));
    } else if (totalTickersPulling == -1) {
      /* connection lost and could not get back */
      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: notificationID,
        channelKey: 'update_progression',
        title: 'Watchlist Update Failed',
        body: 'Internet connection was lost',
        autoDismissible: false,
        color: const Color.fromARGB(255, 70, 130, 180),
        category: NotificationCategory.Progress,
        locked: false,
      ));
    } else if (totalTickersPulling == -2) {
      /* Twelve Data API server is down */
      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: notificationID,
        channelKey: 'update_progression',
        title: 'Watchlist Update Failed',
        body: 'Trouble connecting with stock market through api',
        autoDismissible: false,
        color: const Color.fromARGB(255, 70, 130, 180),
        category: NotificationCategory.Progress,
        locked: false,
      ));
    }
  }

  /* creates bear and bull display text notifications */
  static createBearBullNotifications(List<StockEntity> bullTickerList,
      List<StockEntity> bearTickerList) async {
    /* dismisses the updated notification if bear or bull is triggering */
    if (bullTickerList.isNotEmpty || bearTickerList.isNotEmpty) {
      /* dismisses previous out-of-date notifications */
      await AwesomeNotifications().dismissAllNotifications();
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int notificationId = prefs.getInt('bearBullNotificationID')!;

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
