import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:band_names/providers/socket_provider.dart';
// Pages
import 'package:band_names/pages/home.dart';
import 'package:band_names/pages/status.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We use a multi provider widget
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) => SocketProvider(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          initialRoute: "home",
          routes: {
            // Here we can create routes to move into the app like WEB
            "home": (_) => const HomePage(),
            "status": (_) => const StatusPage(),
          },
        ));
  }
}
