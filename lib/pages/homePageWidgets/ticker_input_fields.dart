import 'package:flutter/material.dart';

import '../../theme.dart';

class TickerInputFields extends StatelessWidget {
  final Function(String) tickerFieldHandler;
  final Function() addTicker;
  final Function(String) removeTicker;
  final String currentTicker;
  const TickerInputFields(this.tickerFieldHandler, this.addTicker,
      this.removeTicker, this.currentTicker,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [tickerTextBox(context), buttonGrouping(context)],
    );
  }

  /* text field for entering a stock ticker for entry or removal */
  SizedBox tickerTextBox(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: TextField(
        onChanged: (updatedTickerValue) =>
            tickerFieldHandler(updatedTickerValue),
        cursorColor: const Color(0xFFCC0000),
        textAlign: TextAlign.center,
        maxLength: 5,
        autocorrect: false,
        enableSuggestions: false,
        style: const TextStyle(
          color: Color(0xFF1B5E20),
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFF0000)),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFAA0000)),
          ),
          hintText: 'Ticker Symbol',
          hintStyle: TextStyle(
              color: Theme.of(context).hintColor,
              fontSize: 22,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  Row buttonGrouping(BuildContext context) {
    return Row(
      children: [
        addTickerButton(),
        removeTickerButton(context),
      ],
    );
  }

  /* button to add a stock ticker to the watchlist */
  Padding addTickerButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: GestureDetector(
          onTap: () => addTicker(),
          child: const Icon(
            Icons.playlist_add,
            size: 45,
            color: Color(0xFF1B5E20),
          )),
    );
  }

  /* button to remove a stock ticker from the watchlist */
  GestureDetector removeTickerButton(BuildContext context) {
    return GestureDetector(
        onTap: () => removeTicker(currentTicker),
        child: const Icon(
          Icons.playlist_remove,
          size: 45,
          color: Color(0xFFCC0000),
        ));
  }
}
