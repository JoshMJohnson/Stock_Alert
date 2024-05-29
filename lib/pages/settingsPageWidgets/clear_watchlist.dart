import 'package:flutter/material.dart';
import 'package:stock_alert/database_repository.dart';

class ClearWatchlist extends StatelessWidget {
  const ClearWatchlist({super.key});

  /* clears the watchlist of stocks */ // todo
  clearWatchlistHandler() async {
    final DatabaseRepository repo = DatabaseRepository.instance;
    repo.clearWatchlist();
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
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
