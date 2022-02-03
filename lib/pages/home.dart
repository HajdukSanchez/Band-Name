import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:band_names/models/band.dart';
import 'package:band_names/components/band_tile.dart';
import 'package:band_names/components/status_icon.dart';
import 'package:band_names/providers/socket_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Band> _bands = [];

  @override
  void initState() {
    // Listen false only declare once the component and then not listen change any more
    final _socketProvider = Provider.of<SocketProvider>(context, listen: false);
    _socketProvider.socket.on("bands", (data) {
      _bands = (data as List).map((band) => Band.fromMap(band)).toList();
      setState(() {});
    });
    super.initState();
  }

  void _addBandDialogs() {
    // Object for managed the text input
    final _textEditingControllerName = TextEditingController();
    final _textEditingControllerVotes = TextEditingController();
    const _dialogAddTitle = 'New Band';
    const _dialogAddButtonText = 'Add band';
    const _dialogDeleteButtonText = 'Dismiss';
    const _placeHolderName = 'Band Name';
    const _placeHolderVotes = 'Number of votes';

    if (Platform.isAndroid) {
      //? Android Dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(_dialogAddTitle),
          // Text Filed for add information
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                  controller: _textEditingControllerName,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: _placeHolderName,
                    labelStyle: TextStyle(color: Colors.grey[350]),
                  )),
              TextField(
                  controller: _textEditingControllerVotes,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: _placeHolderVotes,
                    labelStyle: TextStyle(color: Colors.grey[350]),
                  )),
            ],
          ),
          actions: [
            MaterialButton(
                child: Text(
                  _dialogAddButtonText.toUpperCase(),
                  style: const TextStyle(fontSize: 16),
                ),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => _addBandToList(_textEditingControllerName.text,
                    int.parse(_textEditingControllerVotes.text)))
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
              content: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  CupertinoTextField(
                      controller: _textEditingControllerName,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontSize: 20)),
                  CupertinoTextField(
                      controller: _textEditingControllerVotes,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 20)),
                ],
              ),
              actions: [
                CupertinoDialogAction(
                  child: const Text(_dialogAddButtonText),
                  isDefaultAction: true, // Action for add by default
                  onPressed: () => _addBandToList(
                      _textEditingControllerName.text,
                      int.parse(_textEditingControllerVotes.text)),
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

  void _addBandToList(String name, int votes) {
    final _socketProvider = Provider.of<SocketProvider>(context, listen: false);
    if (name.length > 3) {
      var newBand = {};
      if (votes > 0) {
        newBand = {
          'name': name,
          'votes': votes,
        };
      } else {
        newBand = {
          'name': name,
        };
      }
      _socketProvider.socket.emit("add-band", newBand);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final _socketProvider = Provider.of<SocketProvider>(context);
    bool isConnected = (_socketProvider.socket.connected) ? true : false;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bands stats',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [StatusIcon(isActive: isConnected)],
      ),
      body: ListView.builder(
          //* It is important to add the length of the list rendered
          itemCount: _bands.length,
          itemBuilder: (context, index) => BandTile(band: _bands[index])),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        elevation: 1,
        onPressed: _addBandDialogs,
      ),
    );
  }
}
