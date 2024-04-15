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
    width: 150,
    height: 50,
    child: TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(), hintText: 'Enter a stock ticker'),
    ),
  );
}

/* button to add a stock ticker to the watchlist */
Icon addTickerButton() {
  return const Icon(
    Icons.add_box_outlined,
    size: 35,
    color: Color(0xFF1B5E20),
  );
}

/* button to remove a stock ticker from the watchlist */
Icon removeTickerButton() {
  return const Icon(
    Icons.highlight_remove,
    size: 35,
    color: Color(0xFF1B5E20),
  );
}

Icon watchlistSorter() {
  return const Icon(
    Icons.sort,
    size: 35,
    color: Color(0xFF1B5E20),
  );
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
  debugPrint('Filter button pressed');
}
