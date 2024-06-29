import 'dart:math';

import 'package:awesome_notifications/android_foreground_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:stock_alert/database_repository.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_entity.dart';

class NotificationService {
  /* initializes local notifications */
  static Future init() async {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationService.onActionReceivedMethod,
      onDismissActionReceivedMethod:
          NotificationService.onDismissActionReceivedMethod,
      onNotificationDisplayedMethod:
          NotificationService.onNotificationDisplayedMethod,
      onNotificationCreatedMethod:
          NotificationService.onNotificationCreatedMethod,
    );

    channelCreation();
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
        ),
        NotificationChannel(
          groupKey: 'bear_stocks',
          channelKey: 'bear_channel',
          channelName: 'Bear Stocks',
          channelDescription: 'Provides alerts for stocks that are down.',
          icon: 'resource://drawable/bear_icon',
          defaultPrivacy: NotificationPrivacy.Public,
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
    return await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  /* starts the foreground service */
  static startForegroundService() {
    AndroidForegroundService.startAndroidForegroundService(
      foregroundStartMode: ForegroundStartMode.stick,
      foregroundServiceType: ForegroundServiceType.none,
      content: NotificationContent(
        id: 1,
        channelKey: 'foreground_service',
        title: 'Stock Alert Active...',
        category: NotificationCategory.Service,
        locked: true,
        autoDismissible: false,
        color: const Color.fromARGB(255, 70, 130, 180),
      ),
    );
  }

  /* terminates the foreground service */
  static terminateForegroundService() {
    AndroidForegroundService.stopForeground(1);
  }

  /* terminates all previous scheduled notifications */
  static terminateScheduledNotifications() {
    AwesomeNotifications().cancelAll();
  }

  /* 
    creates a progression notification for pulling 
    updated watchlist ticker data scheduled for a specific time 
  */ // todo create repeating progression notification for pulling watchlist data
  static createScheduledProgression(
    int quanitiyReminders,
    TimeOfDay notification1,
    TimeOfDay notification2,
    TimeOfDay notification3,
  ) {
    /* scheduled daily reminder 1 */ // todo
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 2,
      channelKey: 'update_progression',
      title: 'Updating watchlist',
      body: 'temp body here',
      autoDismissible: false,
      color: const Color.fromARGB(255, 70, 130, 180),
      // notificationLayout: NotificationLayout.ProgressBar,
    ));

    /* scheduled daily reminder 2 */ // todo
    // if (quanitiyReminders >= 2) {
    //   AwesomeNotifications().createNotification(
    //       content: NotificationContent(
    //     id: 3,
    //     channelKey: 'update_progression',
    //     title: 'Updating watchlist',
    //     body: 'temp body here',
    //     autoDismissible: false,
    //     color: const Color.fromARGB(255, 70, 130, 180),
    //   ));
    // }

    /* scheduled daily reminder 3 */ // todo
    // if (quanitiyReminders == 3) {
    //   AwesomeNotifications().createNotification(
    //       content: NotificationContent(
    //     id: 4,
    //     channelKey: 'update_progression',
    //     title: 'Updating watchlist',
    //     body: 'temp body here',
    //     autoDismissible: false,
    //     color: const Color.fromARGB(255, 70, 130, 180),
    //   ));
    // }
  }

  /* updates the current progress bar */ // todo unused
  void updateProgressBar(
      int notificationID, int currentProgress, int totalTickersPulling) {
    int progress =
        min((currentProgress / totalTickersPulling * 100).round(), 100);

    /* still pulling; reached api limit; delaying */
    if (currentProgress < totalTickersPulling) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: notificationID,
        channelKey: 'update_progression',
        title: 'Updating watchlist ($progress)',
        body: 'Gathering updated watchlist data',
        autoDismissible: false,
        color: const Color.fromARGB(255, 70, 130, 180),
        notificationLayout: NotificationLayout.ProgressBar,
        category: NotificationCategory.Progress,
        progress: progress as double,
        locked: true,
      ));
    } else {
      /* finished pulling ticker data from watchlist */
      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: notificationID,
        channelKey: 'update_progression',
        title: 'Watchlist updated',
        body: 'Finished gathering watchlist data',
        autoDismissible: false,
        color: const Color.fromARGB(255, 70, 130, 180),
        category: NotificationCategory.Progress,
        progress: progress as double,
        locked: false,
      ));
    }
  }

  /* creates bear and bull display text notifications */
  static createBearBullNotifications(
      List<StockEntity> bullTickerList, List<StockEntity> bearTickerList) {
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
            '${Emojis.office_chart_increasing} $tempTickerSymbol \$$tempDayChange ($tempPercentChange%) (\$$tempPPS) ${Emojis.office_chart_increasing}';

        /* if last ticker in list of bull stocks given */
        if (tempTicker == bullTickerList.length - 1) {
          bullTickers = '$bullTickers$tickerLine';
          break;
        }

        bullTickers = '$bullTickers$tickerLine\n';
      }

      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: 5,
        channelKey: 'bull_channel',
        title: 'Bull Stocks',
        body: bullTickers,
        autoDismissible: false,
        notificationLayout: NotificationLayout.Inbox,
        color: const Color.fromARGB(255, 22, 129, 24),
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
            '${Emojis.office_chart_decreasing} $tempTickerSymbol -\$$tempDayChange (-$tempPercentChange%) (\$$tempPPS) ${Emojis.office_chart_decreasing}';

        /* if last ticker in list of bull stocks given */
        if (tempTicker == bearTickerList.length - 1) {
          bearTickers = '$bearTickers$tickerLine';
          break;
        }

        bearTickers = '$bearTickers$tickerLine\n';
      }

      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: 6,
        channelKey: 'bear_channel',
        title: 'Bear Stocks',
        body: bearTickers,
        autoDismissible: false,
        notificationLayout: NotificationLayout.Inbox,
        color: const Color.fromARGB(255, 255, 0, 0),
      ));
    }
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {}

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {}

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {}

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {}
}
