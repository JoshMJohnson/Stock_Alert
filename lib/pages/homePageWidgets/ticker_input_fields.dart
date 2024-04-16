import 'package:flutter/material.dart';

class TickerInsertFields extends StatefulWidget {
  const TickerInsertFields({super.key});

  @override
  State<TickerInsertFields> createState() => _TickerInsertFieldsState();
}

class _TickerInsertFieldsState extends State<TickerInsertFields> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [tickerTextBox(), buttonGrouping()],
    );
  }
}

/* text field for entering a stock ticker for entry or removal */
SizedBox tickerTextBox() {
  return const SizedBox(
    width: 120,
    height: 50,
    child: TextField(
      cursorColor: Color(0xFFFF0000),
      textAlign: TextAlign.center,
      autocorrect: false,
      enableSuggestions: false,
      style: TextStyle(
        color: Color(0xFF1B5E20),
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFFF0000)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFAA0000)),
        ),
        hintText: 'Stock Ticker',
        hintStyle: TextStyle(
            color: Color(0xFF1B5E20),
            fontSize: 22,
            fontWeight: FontWeight.normal),
      ),
    ),
  );
}

Row buttonGrouping() {
  return Row(
    children: [
      addTickerButton(),
      removeTickerButton(),
    ],
  );
}

/* button to add a stock ticker to the watchlist */
Padding addTickerButton() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
    child: GestureDetector(
        onTap: () {
          saveTickerHandler();
        },
        child: const Icon(
          Icons.playlist_add,
          size: 45,
          color: Color(0xFF1B5E20),
        )),
  );
}

/* button to remove a stock ticker from the watchlist */
GestureDetector removeTickerButton() {
  return GestureDetector(
      onTap: () {
        removeTickerHandler();
      },
      child: const Icon(
        Icons.playlist_remove,
        size: 45,
        color: Color(0xFFFF0000),
      ));
}

/* saves the new stock ticker to the watchlist if valid */ // todo
saveTickerHandler() {
  debugPrint('Add stock ticker button was pressed');
}

removeTickerHandler() {
  // todo
  debugPrint('Remove stock ticker button was pressed');
}
