import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

// The changeNotifier tell the UI when he need to rebuild the interface
class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;

  get serverStatus => _serverStatus;

  SocketService() {
    initState();
  }

  void initState() {
    try {
      Socket socket = io(
        'http://localhost:2328',
        OptionBuilder()
            .setTransports(['webSocket'])
            .enableAutoConnect()
            .build(),
      );
      // Connect to WebSocket
      socket.connect();

      socket.on('connect', (_) {
        _serverStatus = ServerStatus.Online; // Update the status
        notifyListeners(); // Tell the UI to rebuild
      });
      socket.on('dsconnect', (_) {
        _serverStatus = ServerStatus.Offline; // Update the status
        notifyListeners(); // Tell the UI to rebuild
      });
    } catch (e) {
      throw Error();
    }
  }
}
