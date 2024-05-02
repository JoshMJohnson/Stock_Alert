import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:stock_alert/pages/settingsPageWidgets/notification_toggling.dart';
import 'package:stock_alert/pages/settingsPageWidgets/price_change_threshold.dart';
import 'package:stock_alert/pages/settingsPageWidgets/quantity_notifications_selector.dart';
import 'package:stock_alert/pages/settingsPageWidgets/button_group.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationToggledOn = false;
  double thresholdValue = 5.0;
  int notificationQuantity = 3;
  TimeOfDay notification1 = const TimeOfDay(hour: 11, minute: 11);
  TimeOfDay notification2 = const TimeOfDay(hour: 11, minute: 12);
  TimeOfDay notification3 = const TimeOfDay(hour: 11, minute: 13);

  /* updates/creates daily notifications */ // todo
  saveButtonHandler() async {
    debugPrint(
        'Save button pressed... notificationToggledOn: $notificationToggledOn');

    /* updates async storage of all settings on the device */
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notificationToggle', notificationToggledOn);
  }

  /* updates the notification on/off toggle */
  updateNotificationToggle(bool isToggledOn) {
    setState(() {
      notificationToggledOn = isToggledOn;
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
      todUpdated = await showTimePicker(
          context: context,
          initialTime:
              notification1); // ! get saved time of TOD1 from storage as initialTime

      /* if no updated time was selected; cancel was pressed from within the selector */
      if (todUpdated == null) {
        return;
      }

      setState(() {
        notification1 = todUpdated!;
      });
    } else if (todID == 1) {
      todUpdated = await showTimePicker(
          context: context,
          initialTime:
              notification2); // ! get saved time of TOD2 from storage as initialTime

      /* if no updated time was selected; cancel was pressed from within the selector */
      if (todUpdated == null) {
        return;
      }

      setState(() {
        notification2 = todUpdated!;
      });
    } else {
      todUpdated = await showTimePicker(
          context: context,
          initialTime:
              notification3); // ! get saved time of TOD3 from storage as initialTime

      /* if no updated time was selected; cancel was pressed from within the selector */
      if (todUpdated == null) {
        return;
      }

      setState(() {
        notification3 = todUpdated!;
      });
    }
  }

  /* handles the slider value changing for notification threshold */
  void sliderActionHandler(double currentSliderValue) {
    String roundedSliderValueString = currentSliderValue.toStringAsFixed(2);
    double roundedSliderValueDouble = double.parse(roundedSliderValueString);

    setState(() {
      thresholdValue = roundedSliderValueDouble;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context),
      body: settingsBody(notificationToggledOn, thresholdValue,
          notificationQuantity, notification1, notification2, notification3),
    );
  }

  /* header widget of settings page */
  AppBar header(BuildContext context) {
    return AppBar(
      actions: [Image.asset('assets/bear.png')],
      title: Text(
        'Settings',
        style: TextStyle(
            color: Colors.green[900],
            fontSize: 28,
            fontWeight: FontWeight.w900),
      ),
      centerTitle: false,
      backgroundColor: Colors.green[200],
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
          size: 35,
          color: Colors.green[900],
        ),
      ),
    );
  }

  /* body widget of settings page */
  Container settingsBody(notificationToggledOn, thresholdValue,
      notificationQuantity, notification1, notification2, notification3) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0XAA006400), Color(0xFFA5D6A7)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    NotificationToggle(
                        updateNotificationToggle: updateNotificationToggle,
                        notificationToggledOn: notificationToggledOn),
                    PriceChangeThreshold(
                        sliderActionHandler: sliderActionHandler,
                        thresholdValue: thresholdValue),
                    QuantityNotificationsSelector(
                        quantityNotificationDropdown:
                            quantityNotificationDropdown,
                        changeTODHandler: changeTODHandler,
                        currentOption: notificationQuantity,
                        notification1: notification1,
                        notification2: notification2,
                        notification3: notification3),
                    ButtonGroup(saveButtonHandler: saveButtonHandler)
                  ],
                ))));
  }
}
