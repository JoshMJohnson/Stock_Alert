import 'package:flutter/material.dart';

class InsertFields extends StatefulWidget {
  const InsertFields({super.key});

  @override
  State<InsertFields> createState() => _InsertFieldsState();
}

class _InsertFieldsState extends State<InsertFields> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        tickerTextBox(),
        addTickerButton(),
        removeTickerButton(),
        watchlistSorter()
      ],
    );
  }
}

/* text field for entering a stock ticker for entry or removal */
SizedBox tickerTextBox() {
  return const SizedBox(
    width: 140,
    height: 50,
    child: TextField(
      autocorrect: false,
      enableSuggestions: false,
      style: TextStyle(
          color: Color(0xFF1B5E20),
          fontSize: 20,
          fontWeight: FontWeight.normal),
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFFF0000)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFAA0000)),
        ),
        hintText: 'Enter ticker...',
        hintStyle: TextStyle(
            color: Color(0xFF1B5E20),
            fontSize: 20,
            fontWeight: FontWeight.normal),
      ),
    ),
  );
}

/* button to add a stock ticker to the watchlist */
GestureDetector addTickerButton() {
  return GestureDetector(
      onTap: () {
        saveTickerHandler();
      },
      child: const Icon(
        Icons.playlist_add,
        size: 35,
        color: Color(0xFF1B5E20),
      ));
}

/* button to remove a stock ticker from the watchlist */
GestureDetector removeTickerButton() {
  return GestureDetector(
      onTap: () {
        removeTickerHandler();
      },
      child: const Icon(
        Icons.playlist_remove,
        size: 35,
        color: Color(0xFFFF0000),
      ));
}

GestureDetector watchlistSorter() {
  return GestureDetector(
      onTap: () {
        sortHandler();
      },
      child: const Icon(
        Icons.sort,
        size: 35,
        color: Color(0xFF1B5E20),
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

/* handles the filter button pressed */ // todo
sortHandler() {
  debugPrint('Sort button pressed');
}
