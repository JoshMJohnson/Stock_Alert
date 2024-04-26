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
    /* loads the initial sorting algorithm */
    onLoadSortMethod() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? sortString = prefs.getString('watchlistSort');

      setState(() {
        if (sortString == 'Alpha') {
          displaySortText = 'Alphabetically';
        } else if (sortString == 'Price') {
          displaySortText = 'Ticker Price';
        } else if (sortString == 'Percentage') {
          displaySortText = 'Day Change (%)';
        } else {
          displaySortText = 'Stock Exchange';
        }
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onLoadSortMethod();
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
