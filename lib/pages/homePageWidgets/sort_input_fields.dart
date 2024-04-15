import 'package:flutter/material.dart';

enum SortOptions { alphabetically, tickerPrice, dayChange, stockExchange }

class SortInputFields extends StatefulWidget {
  const SortInputFields({super.key});

  @override
  State<SortInputFields> createState() => _SortInputFieldsState();
}

class _SortInputFieldsState extends State<SortInputFields> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [selectedSortDisplay(), watchlistSorter()],
    );
  }
}

/* displays the currently selected sort method */
Text selectedSortDisplay() {
  int savedSortValue = 0; // todo get value from async storage
  late String displayedSortText;

  if (savedSortValue == SortOptions.alphabetically.index) {
    displayedSortText = 'Alphabetically';
  } else if (savedSortValue == SortOptions.tickerPrice.index) {
    displayedSortText = 'Ticker Price';
  } else if (savedSortValue == SortOptions.dayChange.index) {
    displayedSortText = 'Day Change (%)';
  } else {
    displayedSortText = 'Stock Exchange';
  }

  return Text(displayedSortText,
      style: const TextStyle(
          color: Color(0xFFFF0000),
          fontSize: 22,
          fontWeight: FontWeight.normal));
}

/* displays the sort button */
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

/* handles the sort button pressed */ // todo
sortHandler() {
  debugPrint('Sort button pressed');
}
