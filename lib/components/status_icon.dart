import 'package:flutter/material.dart';

class StatusIcon extends StatelessWidget {
  final bool isActive;

  const StatusIcon({Key? key, required this.isActive}) : super(key: key);

  Widget renderIcon() {
    if (isActive) {
      return const Icon(
        Icons.check_circle,
        color: Colors.green,
      );
    }
    return const Icon(
      Icons.error_outline,
      color: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: renderIcon(),
    );
  }
}
