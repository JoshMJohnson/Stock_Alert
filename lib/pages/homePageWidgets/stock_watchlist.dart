import 'package:flutter/material.dart';

class StockWatchlist extends StatefulWidget {
  const StockWatchlist({super.key});

  @override
  State<StockWatchlist> createState() => _StockWatchlistState();
}

class _StockWatchlistState extends State<StockWatchlist> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [Color(0x33FF0000), Color(0x33A5D6A7)],
          ),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(
              'Stock Ticker $index',
              style: const TextStyle(
                  color: Color(0xFF006400),
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ));
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.black,
            );
          },
        ));
  }
}
