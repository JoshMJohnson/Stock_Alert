import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:stock_alert/pages/settingsPageWidgets/notification_toggling.dart';
import 'package:stock_alert/pages/settingsPageWidgets/price_change_threshold.dart';
import 'package:stock_alert/pages/settingsPageWidgets/quantity_notifications_selector.dart';
import 'package:stock_alert/pages/settingsPageWidgets/button_group.dart';

// ignore: must_be_immutable
class SettingsPage extends StatefulWidget {
  bool notificationToggledOn;
  double thresholdValue;
  int notificationQuantity;
  TimeOfDay notification1;
  TimeOfDay notification2;
  TimeOfDay notification3;

  SettingsPage(
      {super.key,
      required this.notificationToggledOn,
      required this.thresholdValue,
      required this.notificationQuantity,
      required this.notification1,
      required this.notification2,
      required this.notification3});

  @override
  // ignore: no_logic_in_create_state
  State<SettingsPage> createState() => _SettingsPageState(
      notificationToggledOn,
      thresholdValue,
      notificationQuantity,
      notification1,
      notification2,
      notification3);
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

  /* updates/creates daily notifications */ // todo
  saveButtonHandler() async {
    debugPrint(
        '!!!!!!!Save button pressed... notificationToggledOn: $notificationToggledOn');

    /* updates async storage of all settings on the device */
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setBool('notificationToggle', notificationToggledOn);
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
          debugPrint(
              'SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSnotificationToggledOn: $notificationToggledOn SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS');
          Navigator.pop(context, notificationToggledOn);
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
                        notificationToggledOn: notificationToggledOn),
                    PriceChangeThreshold(thresholdValue: thresholdValue),
                    QuantityNotificationsSelector(
                        notificationQuantity: notificationQuantity),
                    ButtonGroup(saveButtonHandler: saveButtonHandler)
                  ],
                ))));
  }
}
