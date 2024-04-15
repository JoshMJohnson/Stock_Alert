import 'package:flutter/material.dart';

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
      children: [watchlistSorter()],
    );
  }
}

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

/* handles the filter button pressed */ // todo
sortHandler() {
  debugPrint('Sort button pressed');
}
