import 'package:flutter/material.dart';

class ClearWatchlist extends StatelessWidget {
  const ClearWatchlist({super.key});

  /* clears the watchlist of stocks */ // todo
  clearWatchlistHandler() async {
    debugPrint('Clear button pressed...');
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        clearWatchlistHandler();
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF0000),
          foregroundColor: const Color(0xFF800000)),
      child: const Text(
        'Clear\nWatchlist',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color(0xFFA5D6A7),
            fontSize: 20,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
