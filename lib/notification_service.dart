import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart' as fgtask;
import 'package:flutter_foreground_task/models/notification_icon.dart';
import 'package:flutter_foreground_task/task_handler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stock_alert/database_repository.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:awesome_notifications/android_foreground_service.dart';

// The callback function should always be a top-level or static function.
@pragma('vm:entry-point')
startCallback() {
  debugPrint('startCallback');
  fgtask.FlutterForegroundTask.setTaskHandler(NotificationService());
}

class NotificationService extends TaskHandler {
  // Called when the task is started.
  @override
  Future<void> onStart(
    DateTime timestamp,
    fgtask.TaskStarter starter,
  ) async {
    debugPrint('onStart');

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int quanitiyReminders = prefs.getInt('notificationQuantity') ?? 3;

    /* loads daily reminder settings */
    final int tod1Hours = prefs.getInt('tod1Hours') ?? 9;
    final int tod2Hours = prefs.getInt('tod2Hours') ?? 13;
    final int tod3Hours = prefs.getInt('tod3Hours') ?? 15;

    final int tod1Minutes = prefs.getInt('tod1Minutes') ?? 45;
    final int tod2Minutes = prefs.getInt('tod2Minutes') ?? 0;
    final int tod3Minutes = prefs.getInt('tod3Minutes') ?? 15;

    final TimeOfDay notification1 =
        TimeOfDay(hour: tod1Hours, minute: tod1Minutes);
    final TimeOfDay notification2 =
        TimeOfDay(hour: tod2Hours, minute: tod2Minutes);
    final TimeOfDay notification3 =
        TimeOfDay(hour: tod3Hours, minute: tod3Minutes);

    // todo begin scheduled tasks
    // createScheduledProgression();

    debugPrint('createScheduledProgression ... quanitiyReminders: * before');

    debugPrint(
        'createScheduledProgression ... quanitiyReminders: $quanitiyReminders');

    debugPrint('createScheduledProgression ... quanitiyReminders: * after');

    String easternTimeZone = 'America/New_York';

    int counterID = 3;
    int dayCounter = 1;

    /* scheduled daily reminder 1 */
    /* monday */
    notificationGenerator(
        easternTimeZone, counterID, dayCounter, notification1);
    counterID++;
    dayCounter++;

    /* tuesday */
    notificationGenerator(
        easternTimeZone, counterID, dayCounter, notification1);
    counterID++;
    dayCounter++;

    /* wednesday */
    notificationGenerator(
        easternTimeZone, counterID, dayCounter, notification1);
    counterID++;
    dayCounter++;

    /* thursday */
    notificationGenerator(
        easternTimeZone, counterID, dayCounter, notification1);
    counterID++;
    dayCounter++;

    /* friday */
    notificationGenerator(
        easternTimeZone, counterID, dayCounter, notification1);
    counterID++;
    dayCounter = 1;

    // ! testing start
    // notificationGenerator(easternTimeZone, counterID, 6, notification1);
    // counterID++;
    // notificationGenerator(easternTimeZone, counterID, 7, notification1);
    // counterID++;
    // ! testing end

    /* scheduled daily reminder 2 */
    if (quanitiyReminders >= 2) {
      /* monday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification2);
      counterID++;
      dayCounter++;

      /* tuesday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification2);
      counterID++;
      dayCounter++;

      /* wednesday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification2);
      counterID++;
      dayCounter++;

      /* thursday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification2);
      counterID++;
      dayCounter++;

      /* friday */
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

      /* tuesday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification3);
      counterID++;
      dayCounter++;

      /* wednesday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification3);
      counterID++;
      dayCounter++;

      /* thursday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification3);
      counterID++;
      dayCounter++;

      /* friday */
      notificationGenerator(
          easternTimeZone, counterID, dayCounter, notification3);
    }

    throw UnimplementedError();
  }

  // Called based on the eventAction set in ForegroundTaskOptions.
  @override
  void onRepeatEvent(DateTime timestamp) {
    debugPrint('onRepeatEvent');
  }

  // Called when the task is destroyed.
  @override
  Future<void> onDestroy(DateTime timestamp) {
    debugPrint('onDestroy');
    throw UnimplementedError();
  }

  /* initializes local notifications */
  static Future init() async {
    // Initialize port for communication between TaskHandler and UI.
    fgtask.FlutterForegroundTask.initCommunicationPort();

    await channelCreation();
    await createListeners();
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {}

  /* triggers on notification displayed */
  @pragma("vm:entry-point")
  static Future onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    /* if scheduled notification; begin pulling data from watchlist */
    /* 18 = starting at 3, 5 days a week, 3 possible daily reminders */
    if (receivedNotification.id! >= 3 && receivedNotification.id! <= 18) {
      DatabaseRepository.updateWatchlist();
    }
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {}

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {}

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
    fgtask.FlutterForegroundTask.init(
      androidNotificationOptions: fgtask.AndroidNotificationOptions(
        channelId: 'foreground_service',
        channelName: 'Foreground Service Notification',
        channelDescription:
            'This notification appears when the foreground service is running.',
        onlyAlertOnce: true,
      ),
      iosNotificationOptions: const fgtask.IOSNotificationOptions(
        showNotification: false,
        playSound: false,
      ),
      foregroundTaskOptions: fgtask.ForegroundTaskOptions(
        eventAction: fgtask.ForegroundTaskEventAction.nothing(),
        autoRunOnBoot: true,
        autoRunOnMyPackageReplaced: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );

    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          groupKey: 'schedule_triggered',
          channelKey: 'schedule_triggered',
          channelName: 'Update Triggered (Required)',
          channelDescription: 'Necessary for notification handling',
          icon: 'resource://drawable/update_icon',
          importance: NotificationImportance.Default,
          playSound: false,
          enableVibration: false,
        ),
        NotificationChannel(
          groupKey: 'updating_stocks',
          channelKey: 'update_progression',
          channelName: 'Update Progression',
          channelDescription: 'Progression on pulling updated ticker data',
          icon: 'resource://drawable/update_icon',
          importance: NotificationImportance.Default,
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
    await fgtask.FlutterForegroundTask.requestNotificationPermission();

    if (!await fgtask.FlutterForegroundTask.canScheduleExactAlarms) {
      // When you call this function, will be gone to the settings page.
      // So you need to explain to the user why set it.
      await fgtask.FlutterForegroundTask.openAlarmsAndRemindersSettings();
    }

    await Permission.scheduleExactAlarm
        .request(); // ! exact alarm permissions being revoked maybe

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

  /* starts the foreground service */ // ! Android 14 issue lies with declaring foreground service type OR exact alarm permissions above
  static startForegroundService() async {
    // AndroidForegroundService.startAndroidForegroundService(
    //   foregroundStartMode: ForegroundStartMode.stick,
    //   foregroundServiceType: ForegroundServiceType.dataSync,
    //   content: NotificationContent(
    //     id: 1,
    //     title: 'Stock Alert is active...',
    //     channelKey: 'foreground_service',
    //     category: NotificationCategory.Service,
    //     autoDismissible: false,
    //     locked: true,
    //   ),
    // );

    fgtask.FlutterForegroundTask.startService(
      serviceId: 1,
      notificationTitle: 'Stock Alert is active...',
      notificationText: 'Keeping you updated on the stock market',
      notificationIcon: const NotificationIcon(
          metaDataName: 'com.stock_alert.service.ServiceIcon'),
      callback: startCallback,
    );
  }

  /* terminates the foreground service */
  static terminateForegroundService() async {
    // AndroidForegroundService.stopForeground(1);
    fgtask.FlutterForegroundTask.stopService();
  }

  /* terminates all previous scheduled notifications */
  static terminateScheduledNotifications() {
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

  /* 
    creates a progression notification for pulling 
    updated watchlist ticker data scheduled for a specific time 
  */
  // static createScheduledProgression() async {
  //   debugPrint(
  //       'createScheduledProgression ... quanitiyReminders: $quanitiyReminders');

  //   String easternTimeZone = 'America/New_York';

  //   int counterID = 3;
  //   int dayCounter = 1;

  //   /* scheduled daily reminder 1 */
  //   /* monday */
  //   notificationGenerator(
  //       easternTimeZone, counterID, dayCounter, notification1);
  //   counterID++;
  //   dayCounter++;

  //   /* tuesday */
  //   notificationGenerator(
  //       easternTimeZone, counterID, dayCounter, notification1);
  //   counterID++;
  //   dayCounter++;

  //   /* wednesday */
  //   notificationGenerator(
  //       easternTimeZone, counterID, dayCounter, notification1);
  //   counterID++;
  //   dayCounter++;

  //   /* thursday */
  //   notificationGenerator(
  //       easternTimeZone, counterID, dayCounter, notification1);
  //   counterID++;
  //   dayCounter++;

  //   /* friday */
  //   notificationGenerator(
  //       easternTimeZone, counterID, dayCounter, notification1);
  //   counterID++;
  //   dayCounter = 1;

  //   // ! testing start
  //   notificationGenerator(easternTimeZone, counterID, 6, notification1);
  //   counterID++;
  //   notificationGenerator(easternTimeZone, counterID, 7, notification1);
  //   counterID++;
  //   // ! testing end

  //   /* scheduled daily reminder 2 */
  //   if (quanitiyReminders >= 2) {
  //     /* monday */
  //     notificationGenerator(
  //         easternTimeZone, counterID, dayCounter, notification2);
  //     counterID++;
  //     dayCounter++;

  //     /* tuesday */
  //     notificationGenerator(
  //         easternTimeZone, counterID, dayCounter, notification2);
  //     counterID++;
  //     dayCounter++;

  //     /* wednesday */
  //     notificationGenerator(
  //         easternTimeZone, counterID, dayCounter, notification2);
  //     counterID++;
  //     dayCounter++;

  //     /* thursday */
  //     notificationGenerator(
  //         easternTimeZone, counterID, dayCounter, notification2);
  //     counterID++;
  //     dayCounter++;

  //     /* friday */
  //     notificationGenerator(
  //         easternTimeZone, counterID, dayCounter, notification2);
  //     counterID++;
  //     dayCounter = 1;
  //   }

  //   /* scheduled daily reminder 3 */
  //   if (quanitiyReminders == 3) {
  //     /* monday */
  //     notificationGenerator(
  //         easternTimeZone, counterID, dayCounter, notification3);
  //     counterID++;
  //     dayCounter++;

  //     /* tuesday */
  //     notificationGenerator(
  //         easternTimeZone, counterID, dayCounter, notification3);
  //     counterID++;
  //     dayCounter++;

  //     /* wednesday */
  //     notificationGenerator(
  //         easternTimeZone, counterID, dayCounter, notification3);
  //     counterID++;
  //     dayCounter++;

  //     /* thursday */
  //     notificationGenerator(
  //         easternTimeZone, counterID, dayCounter, notification3);
  //     counterID++;
  //     dayCounter++;

  //     /* friday */
  //     notificationGenerator(
  //         easternTimeZone, counterID, dayCounter, notification3);
  //   }
  // }

  /* updates the current progress bar */
  static void updateProgressBar(
      int notificationID, int currentProgress, int totalTickersPulling) async {
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
