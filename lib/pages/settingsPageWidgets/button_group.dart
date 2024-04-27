import 'package:flutter/material.dart';
import 'package:stock_alert/pages/settingsPageWidgets/clear_watchlist.dart';
import 'package:stock_alert/pages/settingsPageWidgets/save_button.dart';

// ignore: must_be_immutable
class ButtonGroup extends StatefulWidget {
  TimeOfDay notification1;
  TimeOfDay notification2;
  TimeOfDay notification3;

  ButtonGroup(
      {super.key,
      required this.notification1,
      required this.notification2,
      required this.notification3});

  @override
  State<ButtonGroup> createState() => _ButtonGroupState();
}

class _ButtonGroupState extends State<ButtonGroup> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [ClearWatchlist(), SaveButton()],
    );
  }
}
