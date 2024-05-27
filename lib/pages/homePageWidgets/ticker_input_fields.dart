import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
          color: Theme.of(context).textTheme.bodyMedium!.color,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              width: 3,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 3,
            ),
          ),
          hintText: 'Ticker Symbol',
          hintStyle: TextStyle(
            color: Theme.of(context).hintColor,
            fontSize: 22,
            fontWeight: FontWeight.normal,
          ),
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
        onTap: () => showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text(
              'Add Ticker Symbol',
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  currentTicker,
                ),
                Center(
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: addTicker,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .background,
                          foregroundColor: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .primary,
                        ),
                        child: Text(
                          'Confirm',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context)
                                .buttonTheme
                                .colorScheme!
                                .secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.cancel_presentation,
                          size: 35,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        child: Icon(
          Icons.playlist_add,
          size: 45,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }

  /* button to remove a stock ticker from the watchlist */ // todo create alert similar to add
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
