import 'package:bluetrack/core/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothConnectionPage extends StatefulWidget {
  final BluetoothDevice device;

  const BluetoothConnectionPage({super.key, required this.device});

  @override
  State<BluetoothConnectionPage> createState() =>
      _BluetoothConnectionPageState();
}

class _BluetoothConnectionPageState extends State<BluetoothConnectionPage> {
  String activity = 'unknown';

  @override
  void initState() {
    super.initState();
    _connectToDevice(widget.device);
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      await device.disconnect();
      await device.connect(timeout: const Duration(seconds: 10));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Connected successfully',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );

      List<BluetoothService> services = await device.discoverServices();
      for (BluetoothService service in services) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.properties.notify ||
              characteristic.properties.indicate) {
            await characteristic.setNotifyValue(true);
            characteristic.onValueReceived.listen((value) {
              final stringValue = String.fromCharCodes(value);
              debugPrint("Received: $stringValue");

              setState(() {
                activity = stringValue;
              });
            });
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Connection failed: $e',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String getImage(String act) {
    switch (act) {
      case 'walking':
        return 'https://cdn-icons-png.flaticon.com/512/684/684908.png';
      case 'running':
        return 'https://cdn-icons-png.flaticon.com/512/1144/1144923.png';
      case 'sitting':
        return 'https://cdn-icons-png.flaticon.com/512/2641/2641504.png';
      case 'standing':
        return 'https://cdn-icons-png.flaticon.com/512/4213/4213023.png';
      default:
        return 'https://cdn-icons-png.flaticon.com/512/1995/1995574.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = getImage(activity);

    return CustomScaffold(
      title: 'Activity Status',
      // appBar: AppBar(title: const Text('Activity Status')),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(imageUrl, width: 150, height: 150),
            const SizedBox(height: 20),
            Text(
              'Current Activity: $activity',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
