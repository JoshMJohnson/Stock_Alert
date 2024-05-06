import 'package:flutter/material.dart';

class SortInputFields extends StatelessWidget {
  final Function() sortChangeHandler;
  final String sortAlgorithm;
  const SortInputFields(this.sortChangeHandler, this.sortAlgorithm,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(sortAlgorithm,
            style: const TextStyle(
                color: Color(0xFFCC0000),
                fontSize: 22,
                fontWeight: FontWeight.w600)),
        GestureDetector(
            onTap: () {
              sortChangeHandler();
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
