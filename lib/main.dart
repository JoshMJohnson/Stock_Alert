import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? sortAlgorithm = prefs.getString('watchlistSort') ?? 'Alphabetically';

  runApp(MyApp(sortAlgorithm: sortAlgorithm));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  String sortAlgorithm;
  MyApp({super.key, required this.sortAlgorithm});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'EBGaramond'),
        home: HomePage(sortAlgorithm: sortAlgorithm));
  }
}
