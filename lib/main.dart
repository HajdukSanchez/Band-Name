import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:band_names/services/socket_service.dart';
// Pages
import 'package:band_names/pages/home.dart';
import 'package:band_names/pages/status.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We use a multi provider widget
    return MultiProvider(
        // We add the array of providers
        providers: [
          ChangeNotifierProvider(
            create: (_) => SocketService(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          initialRoute: "status",
          routes: {
            // Here we can create routes to move into the app like WEB
            "home": (_) => const HomePage(),
            "status": (_) => const StatusPage(),
          },
        ));
  }
}
