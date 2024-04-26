import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String displaySortText = ''; // todo change to late rather than initializing

class SortInputFields extends StatefulWidget {
  const SortInputFields({super.key});

  @override
  State<SortInputFields> createState() => _SortInputFieldsState();
}

class _SortInputFieldsState extends State<SortInputFields> {
  /* called on application open */
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onLoadSortMethod();
    });
  }

  /* loads the initial sorting algorithm for the watchlist */
  onLoadSortMethod() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? sortString = prefs.getString('watchlistSort');

    setState(() {
      if (sortString == 'Alphabetically') {
        displaySortText = 'Alphabetically';
      } else if (sortString == 'Ticker Price') {
        displaySortText = 'Ticker Price';
      } else if (sortString == 'Day Change (%)') {
        displaySortText = 'Day Change (%)';
      } else {
        displaySortText = 'Stock Exchange';
      }
    });
  }

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
  return Text(displaySortText,
      style: const TextStyle(
          color: Color(0xFFCC0000), fontSize: 22, fontWeight: FontWeight.w600));
}

/* sort button pressed handler */
sortHandler() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? sortString = prefs.getString('watchlistSort');

  if (sortString == 'Alphabetically') {
    displaySortText = 'Ticker Price';
    await prefs.setString('watchlistSort', 'Ticker Price');
  } else if (sortString == 'Ticker Price') {
    displaySortText = 'Day Change (%)';
    await prefs.setString('watchlistSort', 'Day Change (%)');
  } else if (sortString == 'Day Change (%)') {
    displaySortText = 'Stock Exchange';
    await prefs.setString('watchlistSort', 'Stock Exchange');
  } else {
    displaySortText = 'Alphabetically';
    await prefs.setString('watchlistSort', 'Alphabetically');
  }
}
