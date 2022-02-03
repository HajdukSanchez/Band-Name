import 'package:band_names/models/band.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:band_names/enums/server_status.dart';

class SocketProvider with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  final IO.Socket _socket = IO.io(
      'http://192.168.20.21:3000/',
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .enableAutoConnect()
          .setExtraHeaders({'foo': 'bar'}) // optional
          .build());

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    _socket.on('connect', (_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  void voteBand(String id) {
    _socket.emit('vote-band', {
      "id": id,
    });
  }
}
