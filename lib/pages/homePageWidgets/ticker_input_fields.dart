import 'package:flutter/material.dart';

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
        cursorColor: Theme.of(context).colorScheme.primary,
        textAlign: TextAlign.center,
        maxLength: 5,
        autocorrect: false,
        enableSuggestions: false,
        style: TextStyle(
          color: Theme.of(context).textTheme.displayMedium!.color,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.background, width: 3),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 3),
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
        addTickerButton(context),
        removeTickerButton(context),
      ],
    );
  }

  /* button to add a stock ticker to the watchlist */
  Padding addTickerButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: GestureDetector(
        onTap: () => addTicker(),
        child: Icon(
          Icons.playlist_add,
          size: 45,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }

  /* button to remove a stock ticker from the watchlist */
  GestureDetector removeTickerButton(BuildContext context) {
    return GestureDetector(
      onTap: () => removeTicker(currentTicker),
      child: Icon(
        Icons.playlist_remove,
        size: 45,
        color: Theme.of(context).iconTheme.color,
      ),
    );
  }
}
