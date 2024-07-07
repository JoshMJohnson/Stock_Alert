import 'package:flutter/material.dart';
import 'package:stock_alert/database_repository.dart';

class ClearWatchlist extends StatelessWidget {
  const ClearWatchlist({super.key});

  /* clears the watchlist of stocks */
  clearWatchlistHandler() async {
    final DatabaseRepository repo = DatabaseRepository.instance;
    repo.clearWatchlist();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
          title: Text(
            'Clear Watchlist',
            textScaler: TextScaler.noScaling,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).textTheme.headlineMedium!.color,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                child: Text(
                  'Are you sure?',
                  textScaler: TextScaler.noScaling,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => {
                      clearWatchlistHandler(),
                      Navigator.pop(context), // close alert window
                    },
                    child: Icon(
                      Icons.check_circle_outline,
                      size: 55,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.cancel_outlined,
                      size: 55,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF0000),
          foregroundColor: const Color(0xFF800000)),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Text(
          'Clear\nWatchlist',
          textScaler: TextScaler.noScaling,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
