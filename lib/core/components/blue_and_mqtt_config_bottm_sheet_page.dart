import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/view/bluetooth/blue_config_page.dart';
import 'package:bluetrack/view/bluetooth/blue_connection_page.dart';
import 'package:bluetrack/view/mqtt/mqttConfigPage.dart';
import 'package:bluetrack/view/pages/activity_monitor_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<void> mqttConfigBottomSheetPage(BuildContext context) async {
  var result = await showCupertinoModalBottomSheet(
    // expand: true,
    useRootNavigator: true,
    backgroundColor: context.onBackground,
    context: context,
    builder:
        (context) => SizedBox(
          // height: context.phoneHeight() * .6,
          child: const MqttConfigPage(),
        ),
  );

  if (result != null && result is Map) {
    final broker = result['broker'];
    final topic = result['topic'];

    await Future.delayed(Duration(microseconds: 500));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ActivityMonitorPage(broker: broker, topic: topic),
      ),
    );
  }
}

Future<void> blueConfigConfigBottomSheetPage(BuildContext context) async {
  var result = await showCupertinoModalBottomSheet(
    // expand: true,
    useRootNavigator: true,
    enableDrag: false,
    backgroundColor: context.onBackground,
    context: context,
    builder:
        (context) => SizedBox(
          // height: context.phoneHeight() * .6,
          child: const BlueConfigPage(),
        ),
  );

  if (result is BluetoothDevice) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BluetoothConnectionPage(device: result),
      ),
    );
  } else if (result != '' && result != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Something went wrong, please try again later.',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
