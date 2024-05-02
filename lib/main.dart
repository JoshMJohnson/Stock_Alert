import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /* loads settings from device preferences */
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String sortAlgorithm =
      prefs.getString('watchlistSort') ?? 'Alphabetically';

  runApp(MyApp(sortAlgorithm));
}

class MyApp extends StatelessWidget {
  final String sortAlgorithm;
  const MyApp(this.sortAlgorithm, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'EBGaramond'),
        home: HomePage(sortAlgorithm));
  }
}
