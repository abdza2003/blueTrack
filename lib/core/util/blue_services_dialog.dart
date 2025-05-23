import 'package:flutter/material.dart';

void showBluetoothOffDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Bluetooth is Off'),
        content: const Text('Please turn on Bluetooth and try again.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
