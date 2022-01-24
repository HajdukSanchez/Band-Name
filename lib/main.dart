import 'package:flutter/material.dart';
// Pages
import 'package:band_names/pages/home.dart';
import 'package:band_names/pages/status.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: "status",
      routes: {
        // Here we can create routes to move into the app like WEB
        "home": (_) => const HomePage(),
        "status": (_) => const StatusPage(),
      },
    );
  }
}
