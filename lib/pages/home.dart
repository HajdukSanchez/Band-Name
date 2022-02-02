import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:band_names/models/band.dart';
import 'package:band_names/components/band_tile.dart';
import 'package:band_names/components/status_icon.dart';
import 'package:band_names/providers/socket_provider.dart';
import 'package:provider/provider.dart';
import 'package:band_names/enums/server_status.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Band> _bands = [
    // Band(id: '1', name: 'Metallica', votes: 5),
    // Band(id: '2', name: 'Queen', votes: 3),
    // Band(id: '3', name: 'Iron Maiden', votes: 2),
    // Band(id: '4', name: 'Deep Purple', votes: 1),
    // Band(id: '5', name: 'Led Zeppelin', votes: 0),
  ];

  @override
  void initState() {
    // Listen false only declare once the component and then not listen change any more
    final _socketProvider = Provider.of<SocketProvider>(context, listen: false);
    setState(() {
      _socketProvider.socket.on(
          "bands",
          (data) => {
                _bands =
                    (data as List).map((band) => Band.fromMap(band)).toList()
              });
    });
    super.initState();
  }

  void _addNewBand() {
    // Object for managed the text input
    final _textEditingController = TextEditingController();
    const _dialogAddTitle = 'Add Band';
    const _dialogAddButtonText = 'Add';
    const _dialogDeleteButtonText = 'Dismiss';

    if (Platform.isAndroid) {
      //? Android Dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(_dialogAddTitle),
          // Text Filed for add information
          content: TextField(
              controller: _textEditingController,
              autofocus: true,
              keyboardType: TextInputType.text,
              style: const TextStyle(fontSize: 20)),
          actions: [
            MaterialButton(
              child: Text(
                _dialogAddButtonText.toUpperCase(),
                style: const TextStyle(fontSize: 16),
              ),
              elevation: 5,
              textColor: Colors.blue,
              onPressed: () => _addBandToList(_textEditingController.text),
            )
          ],
        ),
      );
    } else {
      //? iOS Dialog
      showCupertinoDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
              title: const Text(_dialogAddTitle),
              content: CupertinoTextField(
                controller: _textEditingController,
                autofocus: true,
                keyboardType: TextInputType.text,
              ),
              actions: [
                CupertinoDialogAction(
                  child: const Text(_dialogAddButtonText),
                  isDefaultAction: true, // Action for add by default
                  onPressed: () => _addBandToList(_textEditingController.text),
                ),
                CupertinoDialogAction(
                  child: const Text(_dialogDeleteButtonText),
                  isDestructiveAction: true, // Action for destruct the dialog
                  onPressed: () => Navigator.pop(context),
                )
              ],
            );
          });
    }
  }

  void _addBandToList(String name) {
    if (name.length > 3) {
      setState(() {
        _bands.add(Band(
            id: DateTime.now().toString(),
            name: name,
            votes: Random().nextInt(10))); // 0-9 Random number
      });
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final _socketProvider = Provider.of<SocketProvider>(context);

    bool _isConnected() {
      return _socketProvider.socket.connected ? true : false;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bands',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [StatusIcon(isActive: _isConnected())],
      ),
      body: ListView.builder(
          //* It is important to add the length of the list rendered
          itemCount: _bands.length,
          itemBuilder: (context, index) => BandTile(band: _bands[index])),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        elevation: 1,
        onPressed: _addNewBand,
      ),
    );
  }
}
