import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:band_names/providers/socket_provider.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _socketProvider = Provider.of<SocketProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('ServerStatus: ${_socketProvider.serverStatus.name}')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {}, child: const Icon(Icons.message)),
    );
  }
}
