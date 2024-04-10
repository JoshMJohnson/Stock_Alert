import 'package:flutter/material.dart';

class ClearWatchlist extends StatefulWidget {
  const ClearWatchlist({super.key});

  @override
  State<ClearWatchlist> createState() => _ClearWatchlistState();
}

class _ClearWatchlistState extends State<ClearWatchlist> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        clearWatchlistHandler();
      },
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF0000)),
      child: const Text(
        'Clear',
        style: TextStyle(
            color: Color(0xFFA5D6A7),
            fontSize: 20,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  /* clears the watchlist of stocks */ // todo
  clearWatchlistHandler() async {
    debugPrint('Clear button pressed');
  }
}
