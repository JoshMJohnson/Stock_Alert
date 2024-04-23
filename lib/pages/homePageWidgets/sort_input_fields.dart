import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SortInputFields extends StatefulWidget {
  String displaySortText;
  SortInputFields({super.key, required this.displaySortText});

  @override
  State<SortInputFields> createState() =>
      _SortInputFieldsState(displaySortText);
}

class _SortInputFieldsState extends State<SortInputFields> {
  String displaySortText;
  _SortInputFieldsState(this.displaySortText);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        selectedSortDisplay(displaySortText),
        GestureDetector(
            onTap: () {
              setState(() {
                sortHandler(displaySortText);
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
Text selectedSortDisplay(String displaySortText) {
  return Text(displaySortText,
      style: const TextStyle(
          color: Color(0xFFCC0000), fontSize: 22, fontWeight: FontWeight.w600));
}

/* sort button pressed handler */
sortHandler(String displaySortText) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? sortString = prefs.getString('watchlistSort');

  if (sortString == 'Alpha') {
    displaySortText = 'Ticker Price';
    await prefs.setString('watchlistSort', 'Price');
  } else if (sortString == 'Price') {
    displaySortText = 'Day Change (%)';
    await prefs.setString('watchlistSort', 'Percentage');
  } else if (sortString == 'Percentage') {
    displaySortText = 'Stock Exchange';
    await prefs.setString('watchlistSort', 'Exchange');
  } else {
    displaySortText = 'Alphabetically';
    await prefs.setString('watchlistSort', 'Alpha');
  }
}
