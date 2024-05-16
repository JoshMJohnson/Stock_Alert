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
            style: TextStyle(
                color: Theme.of(context).textTheme.displayMedium!.color,
                fontSize: 22,
                fontWeight: FontWeight.w600)),
        GestureDetector(
            onTap: () {
              sortChangeHandler();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.sort,
                size: 40,
                color: Theme.of(context).iconTheme.color,
              ),
            ))
      ],
    );
  }
}
