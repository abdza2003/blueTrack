import 'package:bluetrack/core/components/custom_scaffold.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/constants/space_constant.dart';
import 'package:bluetrack/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class BluetoothConnectionPage extends StatefulWidget {
  final BluetoothDevice device;

  const BluetoothConnectionPage({super.key, required this.device});

  @override
  State<BluetoothConnectionPage> createState() =>
      _BluetoothConnectionPageState();
}

class _BluetoothConnectionPageState extends State<BluetoothConnectionPage> {
  String activity = 'There is no data to receive at the moment.';

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

  getImage(String act) {
    switch (act) {
      case 'walking':
        return {
          'path': '/walking.json',
          'height': 250.0,
          "space": 50.0,
          'message': 'The user is currently walking.',
          'status': 'Walking',
        };
      case 'running':
        return {
          'path': '/running.json',
          'height': 300.0,
          "space": 0.0,
          'message': 'The user is currently running.',
          'status': 'Running',
        };

      case 'sitting':
        return {
          'path': '/sitting.json',
          'height': 250.0,
          "space": 50.0,
          'message': 'The user is currently sitting.',
          'status': 'Sitting',
        };
      case 'standing':
        return {
          'path': '/standing.json',
          'height': 250.0,
          "space": 50.0,
          'message': 'The user is currently standing.',
          'status': 'Standing',
        };
      default:
        return {
          'path': '/nothing.json',
          'height': 200.0,
          "space": 10.0,
          'status': 'No Activity',

          'message': 'No user activity detected at the moment.',
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final info = getImage(activity);

    return CustomScaffold(
      title: 'Activity Status',
      // appBar: AppBar(title: const Text('Activity Status')),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SpaceConstant.instance.heightXXXLarge,
            SpaceConstant.instance.heightMedium,
            SizedBox(
              width: context.phoneWidth(),
              height: (info['height'] as double).h,
              child: Lottie.asset('assets/lottie${info['path']}'),
            ),
            SizedBox(height: (info['space'] as double).h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Txt(
                text: info['status'].toString().toUpperCase(),
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Divider(
                thickness: 1,
                color: ColorConstants.instance.primary.withOpacity(.9),
              ),
            ),
            SpaceConstant.instance.heightXSmall,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Txt(
                text: info['message'],
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
