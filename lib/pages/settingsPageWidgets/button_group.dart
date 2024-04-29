import 'package:flutter/material.dart';
import 'package:stock_alert/pages/settingsPageWidgets/clear_watchlist.dart';
import 'package:stock_alert/pages/settingsPageWidgets/save_button.dart';

// ignore: must_be_immutable
class ButtonGroup extends StatefulWidget {
  Function saveButtonHandler;
  ButtonGroup({super.key, required this.saveButtonHandler});

  @override
  State<ButtonGroup> createState() => _ButtonGroupState(saveButtonHandler);
}

class _ButtonGroupState extends State<ButtonGroup> {
  Function saveButtonHandler;
  _ButtonGroupState(this.saveButtonHandler);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ClearWatchlist(),
        SaveButton(saveButtonHandler: saveButtonHandler)
      ],
    );
  }
}
