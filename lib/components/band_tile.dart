import 'package:flutter/material.dart';
import 'package:band_names/models/band.dart';

class BandTile extends StatelessWidget {
  final Band band;

  const BandTile({Key? key, required this.band}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //* This Widget create and horizontal scrroll for make and action like delete a list member
    return Dismissible(
        key: Key(band.id),
        direction: DismissDirection.startToEnd, // Only one direction allowed
        onDismissed: (direction) {},
        // Element in the background
        background: Container(
          color: Colors.red,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 15.0),
        ),
        child: ListTile(
          leading: CircleAvatar(
            child: Text(band.name.substring(0, 2)),
            backgroundColor: Colors.blue[100],
          ),
          title: Text(band.name),
          trailing:
              Text(band.votes.toString(), style: const TextStyle(fontSize: 20)),
          onTap: () => {print(band.name)},
        ));
  }
}
