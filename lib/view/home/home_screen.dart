// ignore_for_file: use_build_context_synchronously

import 'package:bluetrack/core/components/custom_scaffold.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/space_constant.dart';
import 'package:bluetrack/core/util/blue_services_dialog.dart';
import 'package:bluetrack/core/util/location_services_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String receivedValue = 'No data received yet';

  @override
  void dispose() {
    FlutterBluePlus.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Home Page',

      // appBar: AppBar(title: const Text('Bluetooth Home')),
      child: Center(
        child: Column(
          children: [
            SpaceConstant.instance.heightXXXLarge,
            SpaceConstant.instance.heightXXXLarge,
            SpaceConstant.instance.heightXXXLarge,
            ElevatedButton(
              onPressed: _startScanAndShowDialog,
              child: Txt(text: 'Search Devices', color: Colors.white),
            ),
            SpaceConstant.instance.heightMedium,
            Txt(
              text: 'Received Values',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            SpaceConstant.instance.heightXSmall,
            Txt(text: receivedValue, fontSize: 12.sp),
          ],
        ),
      ),
    );
  }

  Future<void> _startScanAndShowDialog() async {
    bool isReady = await _checkBluetoothAndPermissions();

    if (!isReady) return;

    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.only(top: 15.h, bottom: 5.h),
          title: const Center(child: Text('BLE List')),
          content: SizedBox(
            width: double.maxFinite,
            height: 250.h,
            child: StreamBuilder<List<ScanResult>>(
              stream: FlutterBluePlus.scanResults,
              builder: (context, snapshot) {
                final results = snapshot.data ?? [];
                if (results.isEmpty) {
                  return const Center(child: CupertinoActivityIndicator());
                }
                return ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final device = results[index].device;
                    return ListTile(
                      leading: const Icon(Icons.bluetooth_audio),
                      title: Text(
                        device.name.isNotEmpty ? device.name : device.id.id,
                      ),
                      subtitle: Text(device.id.id),
                      onTap: () async {
                        Navigator.pop(context);

                        await Future.delayed(const Duration(seconds: 1));

                        await _connectToDevice(device);
                      },
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<bool> _checkBluetoothAndPermissions() async {
    // Bluetooth check
    BluetoothAdapterState state = await FlutterBluePlus.adapterState.first;
    if (state != BluetoothAdapterState.on) {
      try {
        await FlutterBluePlus.turnOn();
        state = await FlutterBluePlus.adapterState.first;
        if (state != BluetoothAdapterState.on) {
          showBluetoothOffDialog(context);
          return false;
        }
      } catch (e) {
        showBluetoothOffDialog(context);
        return false;
      }
    }

    // Permission check
    final permissionStatus = await Permission.location.request();
    if (!permissionStatus.isGranted) {
      showLocationPermissionDialog(context);
      return false;
    }

    // Location Services check
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      showEnableLocationServicesDialog(context);
      return false;
    }

    return true;
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
              String stringValue = String.fromCharCodes(value);

              setState(() {
                receivedValue = stringValue;
              });

              debugPrint("Received value: $stringValue");
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
}
