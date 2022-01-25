import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

// The changeNotifier tell the UI when he need to rebuild the interface
class SocketService with ChangeNotifier {
  final ServerStatus _serverStatus = ServerStatus.Connecting;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    IO.Socket _socket = IO.io('http://localhost:3000', {
      'tranports': ['websocket'],
      'autoConnect': true
    });
    _socket.connect();

    _socket.on('connect', (_) {
      print('Connect');
      _socket.emit('msg', 'Hello World');
    });
    _socket.on('event', (data) => print('Event: $data'));
    _socket.onDisconnect((_) => print('Disconnect'));
  }
}
