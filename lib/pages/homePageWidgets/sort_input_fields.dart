import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SortInputFields extends StatefulWidget {
  String sortAlgorithm;
  SortInputFields({super.key, required this.sortAlgorithm});

  @override
  State<SortInputFields> createState() => _SortInputFieldsState(sortAlgorithm);
}

class _SortInputFieldsState extends State<SortInputFields> {
  String sortAlgorithm;
  _SortInputFieldsState(this.sortAlgorithm);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        selectedSortDisplay(sortAlgorithm),
        GestureDetector(
            onTap: () {
              setState(() {
                sortAlgorithm = sortHandler(sortAlgorithm);
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
Text selectedSortDisplay(String sortAlgorithm) {
  return Text(sortAlgorithm,
      style: const TextStyle(
          color: Color(0xFFCC0000), fontSize: 22, fontWeight: FontWeight.w600));
}

/* sort button pressed handler */
String sortHandler(String sortAlgorithm) {
  if (sortAlgorithm == 'Alphabetically') {
    sortAlgorithm = 'Ticker Price';
  } else if (sortAlgorithm == 'Ticker Price') {
    sortAlgorithm = 'Day Change (%)';
  } else if (sortAlgorithm == 'Day Change (%)') {
    sortAlgorithm = 'Stock Exchange';
  } else {
    sortAlgorithm = 'Alphabetically';
  }

  updateSortPreferences(sortAlgorithm);

  return sortAlgorithm;
}

updateSortPreferences(String sortAlgorithm) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('watchlistSort', sortAlgorithm);
}
