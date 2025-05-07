import 'dart:async';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/android_foreground_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stock_alert/database_repository.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {}

  /* triggers on notification displayed */
  @pragma("vm:entry-point")
  static Future onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {}

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {}

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {}

  /* callback for notificationtrigger in background */
  @pragma('vm:entry-point')
  static triggeredNotification(int notificationID) async {
    debugPrint('triggeredNotification');

    if (notificationID >= 3 && notificationID <= 5) {
      debugPrint('got here');
      DatabaseRepository.updateWatchlist();

      await AndroidAlarmManager.oneShotAt(
        DateTime.now().add(const Duration(days: 1)),
        notificationID,
        triggeredNotification,
        exact: true,
        wakeup: true,
        allowWhileIdle: true,
        rescheduleOnReboot: true,
        alarmClock: true,
      );
    }
  }

  /* initializes local notifications */
  static Future init() async {
    await channelCreation();
    await createListeners();
    await AndroidAlarmManager.initialize();
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
    ];

    // Check if the basic permission was granted by the user
    await AwesomeNotifications().requestPermissionToSendNotifications(
      permissions: permissionList,
    );

    await Permission.scheduleExactAlarm.request(); /* exact alarm permission */
  }

  /* starts the foreground service */
  static startForegroundService() async {
    await AndroidForegroundService.startAndroidForegroundService(
      foregroundStartMode: ForegroundStartMode.stick,
      foregroundServiceType: ForegroundServiceType.manifest,
      content: NotificationContent(
        id: 1,
        title: 'Stock Alert is active',
        body: 'Keeping you updated on the stock market',
        channelKey: 'foreground_service',
        category: NotificationCategory.Service,
      ),
    );
  }

  /* terminates the foreground service and terminates all previous scheduled notifications */
  static terminateForegroundService() async {
    await AndroidAlarmManager.cancel(3);
    await AndroidAlarmManager.cancel(4);
    await AndroidAlarmManager.cancel(5);
    await AndroidForegroundService.stopForeground(1);
  }

  /* schedules the reminders when save was pressed within settings page */
  static scheduleReminders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final int notificationQuantity = prefs.getInt('notificationQuantity') ?? 3;

    int tod1Hours = prefs.getInt('tod1Hours')!;
    int tod1Minutes = prefs.getInt('tod1Minutes')!;
    int tod2Hours = prefs.getInt('tod2Hours')!;
    int tod2Minutes = prefs.getInt('tod2Minutes')!;
    int tod3Hours = prefs.getInt('tod3Hours')!;
    int tod3Minutes = prefs.getInt('tod3Minutes')!;

    int counterID = 3;

    /* scheduled daily reminder 1 */
    notificationGenerator(counterID, tod1Hours, tod1Minutes);
    counterID++;

    /* scheduled daily reminder 2 */
    if (notificationQuantity >= 2) {
      notificationGenerator(counterID, tod2Hours, tod2Minutes);
      counterID++;
    }

    /* scheduled daily reminder 2 */
    if (notificationQuantity == 3) {
      notificationGenerator(counterID, tod3Hours, tod3Minutes);
    }
  }

  /* creates scheduled notification */
  static notificationGenerator(int notificationID, int hour, int minute) async {
    /* date time variables */
    DateTime currentDateTime = DateTime.now();
    DateTime currentDateTimePlus1Day = currentDateTime.add(
      const Duration(days: 1),
    );

    /* sets alarm dateTime */
    DateTime triggerTime = DateTime(
      currentDateTime.year,
      currentDateTime.month,
      currentDateTime.day,
      hour,
      minute,
      0,
      0,
      0,
    );

    bool hasHourMinutePassedToday = currentDateTime.compareTo(triggerTime) > 0;

    if (hasHourMinutePassedToday) {
      /* alarm time is in the past for current day */
      triggerTime = DateTime(
        currentDateTimePlus1Day.year,
        currentDateTimePlus1Day.month,
        currentDateTimePlus1Day.day,
        hour,
        minute,
        0,
        0,
        0,
      );
    }

    await AndroidAlarmManager.oneShotAt(
      triggerTime,
      notificationID,
      triggeredNotification,
      exact: true,
      wakeup: true,
      allowWhileIdle: true,
      rescheduleOnReboot: true,
      alarmClock: true,
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
  static createBearBullNotifications(
    List<StockEntity> bullTickerList,
    List<StockEntity> bearTickerList,
  ) async {
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
