import 'package:flutter/material.dart';

enum SortOptions { alphabetically, tickerPrice, dayChange, stockExchange }

late String displayedSortText;
int savedSortValue = 0; // todo get value from async storage

class SortInputFields extends StatefulWidget {
  const SortInputFields({super.key});

  @override
  State<SortInputFields> createState() => _SortInputFieldsState();
}

class _SortInputFieldsState extends State<SortInputFields> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        selectedSortDisplay(),
        GestureDetector(
            onTap: () {
              setState(() {
                sortHandler();
              });
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.sort,
                size: 40,
                color: Color(0xFF1B5E20),
              ),
            ))
      ],
    );
  }
}

/* displays the currently selected sort method */
Text selectedSortDisplay() {
  sortMethodFinder();

  return Text(displayedSortText,
      style: const TextStyle(
          color: Color(0xFFFF0000), fontSize: 22, fontWeight: FontWeight.w600));
}

/* sort button pressed handler */ // todo
sortHandler() {
  debugPrint('Sort button pressed... savedSortValue: $savedSortValue');

  if (savedSortValue == 3) {
    savedSortValue = 0;
  } else {
    savedSortValue++;
  }

  sortMethodFinder();
}

/* assigns the value of the text display for current sort method selected */
sortMethodFinder() {
  if (savedSortValue == SortOptions.alphabetically.index) {
    displayedSortText = 'Alphabetically';
  } else if (savedSortValue == SortOptions.tickerPrice.index) {
    displayedSortText = 'Ticker Price';
  } else if (savedSortValue == SortOptions.dayChange.index) {
    displayedSortText = 'Day Change (%)';
  } else {
    displayedSortText = 'Stock Exchange';
  }
}
