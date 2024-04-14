import 'package:flutter/material.dart';

class InsertFields extends StatefulWidget {
  const InsertFields({super.key});

  @override
  State<InsertFields> createState() => _InsertFieldsState();
}

class _InsertFieldsState extends State<InsertFields> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFF0000)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [tickerTextBox(), addTickerButton(), removeTickerButton()],
      ),
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
ElevatedButton addTickerButton() {
  return ElevatedButton(onPressed: saveTickerHandler(), child: const Text('+'));
}

/* button to remove a stock ticker from the watchlist */
ElevatedButton removeTickerButton() {
  return ElevatedButton(
      onPressed: removeTickerHandler(), child: const Text('-'));
}

/* saves the new stock ticker to the watchlist if valid */ // todo
saveTickerHandler() {
  debugPrint('Add stock ticker button was pressed');
}

removeTickerHandler() {
  // todo
  debugPrint('Remove stock ticker button was pressed');
}
