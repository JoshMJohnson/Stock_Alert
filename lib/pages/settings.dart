import 'package:flutter/material.dart';
import 'package:stock_alert/pages/settingsPageWidgets/notification_toggling.dart';
import 'package:stock_alert/pages/settingsPageWidgets/price_change_threshold.dart';
import 'package:stock_alert/pages/settingsPageWidgets/quantity_notifications_selector.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context),
      body: body(),
    );
  }

  /* header widget of settings page */
  AppBar header(BuildContext context) {
    return AppBar(
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
  Container body() {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0XAA006400), Color(0xFFA5D6A7)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: const Column(
          children: [
            NotificationToggle(),
            PriceChangeThreshold(),
            QuantityNotificationsSelector()
          ],
        ));
  }
}
