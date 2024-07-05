import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_alert/notification_service.dart';
import 'package:stock_alert/pages/settingsPageWidgets/notification_toggling.dart';
import 'package:stock_alert/pages/settingsPageWidgets/price_change_threshold.dart';
import 'package:stock_alert/pages/settingsPageWidgets/quantity_notifications_selector.dart';
import 'package:stock_alert/pages/settingsPageWidgets/clear_watchlist.dart';
import 'package:stock_alert/pages/settingsPageWidgets/save_button.dart';

class SettingsPage extends StatefulWidget {
  final bool notificationToggledOn;
  final double thresholdValue;
  final int notificationQuantity;
  final TimeOfDay notification1;
  final TimeOfDay notification2;
  final TimeOfDay notification3;

  const SettingsPage(
      this.notificationToggledOn,
      this.thresholdValue,
      this.notificationQuantity,
      this.notification1,
      this.notification2,
      this.notification3,
      {super.key});

  @override
  State<SettingsPage> createState() =>
      // ignore: no_logic_in_create_state
      _SettingsPageState(notificationToggledOn, thresholdValue,
          notificationQuantity, notification1, notification2, notification3);
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationToggledOn;
  double thresholdValue;
  int notificationQuantity;
  TimeOfDay notification1;
  TimeOfDay notification2;
  TimeOfDay notification3;

  _SettingsPageState(
      this.notificationToggledOn,
      this.thresholdValue,
      this.notificationQuantity,
      this.notification1,
      this.notification2,
      this.notification3);

  /* updates the notification on/off toggle */
  void updateNotificationToggle(bool isToggledOn) {
    setState(() {
      notificationToggledOn = isToggledOn;
    });
  }

  /* handles the slider value changing for notification threshold */
  void sliderActionHandler(double currentSliderValue) {
    String roundedSliderValueString = currentSliderValue.toStringAsFixed(2);
    double roundedSliderValueDouble = double.parse(roundedSliderValueString);

    setState(() {
      thresholdValue = roundedSliderValueDouble;
    });
  }

  /* handles a change in dropdown box selection for quantity of notifications */
  void quantityNotificationDropdown(int selectedValue) {
    setState(() {
      notificationQuantity = selectedValue;
    });
  }

  /* adjusts and saves updated time of day reminders */
  changeTODHandler(int todID) async {
    late final TimeOfDay? todUpdated;

    if (todID == 0) {
      todUpdated =
          await showTimePicker(context: context, initialTime: notification1);

      /* if no updated time was selected; cancel was pressed from within the selector */
      if (todUpdated == null) {
        return;
      }

      setState(() {
        notification1 = todUpdated!;
      });
    } else if (todID == 1) {
      todUpdated =
          await showTimePicker(context: context, initialTime: notification2);

      /* if no updated time was selected; cancel was pressed from within the selector */
      if (todUpdated == null) {
        return;
      }

      setState(() {
        notification2 = todUpdated!;
      });
    } else {
      todUpdated =
          await showTimePicker(context: context, initialTime: notification3);

      /* if no updated time was selected; cancel was pressed from within the selector */
      if (todUpdated == null) {
        return;
      }

      setState(() {
        notification3 = todUpdated!;
      });
    }
  }

  /* saves all current settings into device preferences; async storage */
  savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notificationToggle', notificationToggledOn);
    prefs.setDouble('thresholdValue', thresholdValue);
    prefs.setInt('notificationQuantity', notificationQuantity);

    /* time of day preference variables */
    final int tod1Hours = notification1.hour;
    final int tod2Hours = notification2.hour;
    final int tod3Hours = notification3.hour;

    final int tod1Minutes = notification1.minute;
    final int tod2Minutes = notification2.minute;
    final int tod3Minutes = notification3.minute;

    prefs.setInt('tod1Hours', tod1Hours);
    prefs.setInt('tod2Hours', tod2Hours);
    prefs.setInt('tod3Hours', tod3Hours);

    prefs.setInt('tod1Minutes', tod1Minutes);
    prefs.setInt('tod2Minutes', tod2Minutes);
    prefs.setInt('tod3Minutes', tod3Minutes);
  }

  /* updates the notification settings */
  updateNotificationSettings(bool permissionsChecked) async {
    if (notificationToggledOn) {
      /* notifications are turned on */
      bool isAllowedToSendNotification =
          await NotificationService.checkPermissions();

      if (!isAllowedToSendNotification && !permissionsChecked) {
        await NotificationService.requestPermissions();
        updateNotificationSettings(true);
      } else if (!isAllowedToSendNotification && permissionsChecked) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        setState(() {
          notificationToggledOn = false;
          prefs.setBool('notificationToggle', false);
        });
      } else {
        /* terminate previous notifications; foreground and reminders */
        NotificationService.terminateForegroundService();
        NotificationService.terminateScheduledNotifications();

        /* turns Stock Alert active */
        NotificationService.startForegroundService();
        NotificationService.createScheduledProgression(
            notificationQuantity, notification1, notification2, notification3);
      }
    } else {
      /* notifications turned off; terminate all existing notifications */
      NotificationService.terminateForegroundService();
      NotificationService.terminateScheduledNotifications();
    }
  }

  /* updates/creates daily notifications */
  saveButtonHandler() {
    savePreferences();
    updateNotificationSettings(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context),
      body: settingsBody(),
    );
  }

  /* header widget of settings page */
  AppBar header(BuildContext context) {
    return AppBar(
      title: Text(
        'Settings',
        textScaler: TextScaler.noScaling,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium!.color,
          fontSize: 28,
          fontWeight: FontWeight.w900,
        ),
      ),
      centerTitle: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      actions: [
        Image.asset('assets/bear.png'),
        Image.asset('assets/bull.png'),
      ],
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
          size: 35,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }

  /* body widget of settings page */
  Container settingsBody() {
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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            NotificationToggle(
              updateNotificationToggle: updateNotificationToggle,
              notificationToggledOn: notificationToggledOn,
            ),
            PriceChangeThreshold(
              sliderActionHandler: sliderActionHandler,
              thresholdValue: thresholdValue,
            ),
            QuantityNotificationsSelector(
              quantityNotificationDropdown: quantityNotificationDropdown,
              changeTODHandler: changeTODHandler,
              notificationQuantity: notificationQuantity,
              notification1: notification1,
              notification2: notification2,
              notification3: notification3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const ClearWatchlist(),
                SaveButton(saveButtonHandler),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
