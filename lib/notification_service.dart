import 'package:awesome_notifications/android_foreground_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

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
        title: 'Stock Alert',
        body: 'Active...',
        category: NotificationCategory.Service,
        locked: true,
        autoDismissible: false,
      ),
    );
  }

  /* terminates the foreground service */
  static terminateForegroundService() {
    AndroidForegroundService.stopForeground(1);
  }

  /* creates repeating reminder notifications */ // todo turn into scheduled reminders
  static createScheduledReminderNotifications(
    int quanitiyReminders,
    TimeOfDay notification1,
    TimeOfDay notification2,
    TimeOfDay notification3,
  ) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 2,
      channelKey: 'update_progression',
      title: 'Updating watchlist',
      body: 'temp body here',
      autoDismissible: false,
    ));

    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 3,
      channelKey: 'bull_channel',
      title: 'Bull title',
      body: 'temp body here',
      autoDismissible: false,
    ));

    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 4,
      channelKey: 'bear_channel',
      title: 'Bear title',
      body: 'temp body here',
      autoDismissible: false,
    ));
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
