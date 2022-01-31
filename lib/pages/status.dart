import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:band_names/providers/socket_provider.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final socketProvider = Provider.of<SocketProvider>(context);

    void emitMessage() {
      socketProvider.emit('message', <String, dynamic>{
        'nombre': 'Flutter',
        'mensaje': 'Hola desde Flutter',
      });
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('ServerStatus: ${socketProvider.serverStatus.name}')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: emitMessage, child: const Icon(Icons.message)),
    );
  }
}
