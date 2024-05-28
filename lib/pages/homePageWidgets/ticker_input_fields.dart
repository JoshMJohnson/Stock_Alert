import 'package:flutter/material.dart';
import 'package:stock_alert/helper_functions.dart';

class TickerInputFields extends StatefulWidget {
  final Function(String) tickerFieldHandler;
  final Function() addTicker;
  final Function(String) removeTicker;
  final String currentTicker;

  const TickerInputFields(this.tickerFieldHandler, this.addTicker,
      this.removeTicker, this.currentTicker,
      {super.key});

  @override
  State<TickerInputFields> createState() => _TickerInputFieldsState();
}

class _TickerInputFieldsState extends State<TickerInputFields> {
  final tickerTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        tickerTextBox(context),
        buttonGrouping(context),
      ],
    );
  }

  /* text field for entering a stock ticker for entry or removal */
  SizedBox tickerTextBox(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: TextField(
        controller: tickerTextController,
        inputFormatters: [
          ChangeToUpperCaseText(),
        ],
        onChanged: (updatedTickerValue) =>
            widget.tickerFieldHandler(updatedTickerValue.toUpperCase()),
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
        onTap: () => widget.currentTicker.isNotEmpty
            ? showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(
                    'Add\nTicker Symbol',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headlineMedium!.color,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 5,
                          ),
                        ),
                        child: Text(
                          widget.currentTicker,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () => {
                                widget.addTicker(),
                                Navigator.pop(context), // close alert window
                                FocusManager.instance.primaryFocus
                                    ?.unfocus(), // close keyboard visibility
                              },
                              child: Icon(
                                Icons.check_circle_outline,
                                size: 55,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.cancel_outlined,
                                size: 55,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Icon(
                Icons.playlist_add,
                size: 45,
                color: Theme.of(context).iconTheme.color,
              ),
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
      onTap: () => widget.currentTicker.isNotEmpty
          ? showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text(
                  'Remove\nTicker Symbol',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headlineMedium!.color,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 5,
                        ),
                      ),
                      child: Text(
                        widget.currentTicker,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () => {
                              widget.removeTicker(widget.currentTicker),
                              Navigator.pop(context), // close alert window
                              FocusManager.instance.primaryFocus
                                  ?.unfocus(), // close keyboard visibility
                            },
                            child: Icon(
                              Icons.check_circle_outline,
                              size: 55,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.cancel_outlined,
                              size: 55,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Icon(
              Icons.playlist_remove,
              size: 45,
              color: Theme.of(context).iconTheme.color,
            ),
      child: Icon(
        Icons.playlist_remove,
        size: 45,
        color: Theme.of(context).iconTheme.color,
      ),
    );
  }
}
