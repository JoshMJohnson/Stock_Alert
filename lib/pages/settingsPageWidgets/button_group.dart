import 'package:flutter/material.dart';
import 'package:stock_alert/pages/settingsPageWidgets/clear_watchlist.dart';
import 'package:stock_alert/pages/settingsPageWidgets/save_button.dart';

class ButtonGroup extends StatelessWidget {
  final Function saveButtonHandler;
  const ButtonGroup({super.key, required this.saveButtonHandler});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [const ClearWatchlist(), SaveButton(saveButtonHandler)],
    );
  }
}
