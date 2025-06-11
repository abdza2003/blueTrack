// lib/view/mqtt/BlueConfigPage.dart
import 'package:bluetrack/core/components/auth_custom_button.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/border_constant.dart';
import 'package:bluetrack/core/constants/space_constant.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:bluetrack/core/extension/context_extension.dart';
import 'package:bluetrack/core/util/blue_services_dialog.dart';
import 'package:bluetrack/core/util/location_services_dialog.dart';
import 'package:bluetrack/view/bluetooth/blue_connection_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class BlueConfigPage extends StatefulWidget {
  const BlueConfigPage({super.key});

  @override
  State<BlueConfigPage> createState() => _BlueConfigPageState();
}

class _BlueConfigPageState extends State<BlueConfigPage> {
  final TextEditingController _brokerController = TextEditingController();
  final TextEditingController _topicController = TextEditingController();

  List<ScanResult> scanResults = [];
  BluetoothDevice? selectedDevice;
  String receivedValue = 'No data received yet';

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  @override
  void dispose() {
    _brokerController.dispose();
    _topicController.dispose();
    FlutterBluePlus.stopScan();
    super.dispose();
  }

  Future<void> _startScan() async {
    bool isReady = await _checkBluetoothAndPermissions();
    if (!isReady) return;

    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        scanResults = results;
      });
    });
  }

  Future<bool> _checkBluetoothAndPermissions() async {
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

    final permissionStatus = await Permission.location.request();
    if (!permissionStatus.isGranted) {
      showLocationPermissionDialog(context);
      return false;
    }

    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      showEnableLocationServicesDialog(context);
      return false;
    }

    return true;
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    Navigator.pop(context, selectedDevice);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => BluetoothConnectionPage(device: device),
    //   ),
    // );
    // try {
    //   await device.disconnect(); // Ensure clean state
    //   await device.connect(timeout: const Duration(seconds: 10));

    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text(
    //         'Connected successfully',
    //         style: TextStyle(color: Colors.white),
    //       ),
    //       backgroundColor: Colors.green,
    //     ),
    //   );

    //   List<BluetoothService> services = await device.discoverServices();
    //   for (BluetoothService service in services) {
    //     for (BluetoothCharacteristic characteristic
    //         in service.characteristics) {
    //       if (characteristic.properties.notify ||
    //           characteristic.properties.indicate) {
    //         await characteristic.setNotifyValue(true);
    //         characteristic.onValueReceived.listen((value) {
    //           setState(() {
    //             receivedValue = String.fromCharCodes(value);
    //           });
    //           debugPrint("Received value: ${String.fromCharCodes(value)}");
    //         });
    //       }
    //     }
    //   }
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(
    //         'Connection failed: $e',
    //         style: const TextStyle(color: Colors.white),
    //       ),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Txt(text: 'Discovered Devices', fontSize: 15.sp),
                centerTitle: false,
                iconTheme: IconThemeData(color: context.inverse),
              ),
              SpaceConstant.instance.heightXXSmall,

              /// الأجهزة المكتشفة
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(':', style: TextStyle(fontWeight: FontWeight.bold)),
                    // SizedBox(height: 10.h),
                    scanResults.isEmpty
                        ? Center(child: CupertinoActivityIndicator())
                        : SizedBox(
                          width: context.phoneWidth(),
                          height: 200.h,
                          child: ListView.builder(
                            padding: EdgeInsets.all(0.0),
                            shrinkWrap: true,
                            // physics: BouncingScrollPhysics(),
                            itemCount: scanResults.length,
                            itemBuilder: (context, index) {
                              final device = scanResults[index].device;
                              final deviceName =
                                  device.name.isNotEmpty
                                      ? device.name
                                      : device.id.id;
                              final isSelected =
                                  selectedDevice?.id == device.id;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDevice = device;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.h,
                                    horizontal: 10.w,
                                  ),
                                  margin: EdgeInsets.symmetric(vertical: 5.h),
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected
                                            ? Colors.blue.shade50
                                            : Colors.transparent,
                                    borderRadius:
                                        BorderConstant
                                            .instance
                                            .allSmallCircular,
                                    border: Border.all(
                                      color:
                                          isSelected
                                              ? Colors.blue
                                              : Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.bluetooth,
                                        color:
                                            isSelected
                                                ? Colors.blue
                                                : context.inverse.withOpacity(
                                                  .9,
                                                ),
                                      ),
                                      SpaceConstant.instance.widthXSmall,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              deviceName,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    isSelected
                                                        ? Colors.blue
                                                        : context.inverse,
                                              ),
                                            ),
                                            SpaceConstant
                                                .instance
                                                .heightXXSmall,
                                            Text(
                                              device.id.id,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color:
                                                    isSelected
                                                        ? Colors.blue
                                                            .withOpacity(.8)
                                                        : context.inverse
                                                            .withOpacity(.8),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  ],
                ),
              ),

              SpaceConstant.instance.heightMedium,

              /// زر الاتصال
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: AuthCustomButton(
                  onTap:
                      selectedDevice != null
                          ? () async => await _connectToDevice(selectedDevice!)
                          : null,
                  text: 'Connect',
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}


// class _BlueConfigPageState extends State<BlueConfigPage> {
//   final TextEditingController _brokerController = TextEditingController();
//   final TextEditingController _topicController = TextEditingController();

//   @override
//   void dispose() {
//     _brokerController.dispose();
//     _topicController.dispose();

//     super.dispose();
//   }

//   Future<void> _startScanAndShowDialog() async {
//     bool isReady = await _checkBluetoothAndPermissions();

//     if (!isReady) return;

//     FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           contentPadding: EdgeInsets.zero,
//           titlePadding: EdgeInsets.only(top: 15.h, bottom: 5.h),
//           title: const Center(child: Text('BLE List')),
//           content: SizedBox(
//             width: double.maxFinite,
//             height: 250.h,
//             child: StreamBuilder<List<ScanResult>>(
//               stream: FlutterBluePlus.scanResults,
//               builder: (context, snapshot) {
//                 final results = snapshot.data ?? [];
//                 if (results.isEmpty) {
//                   return const Center(child: CupertinoActivityIndicator());
//                 }
//                 return ListView.builder(
//                   itemCount: results.length,
//                   itemBuilder: (context, index) {
//                     final device = results[index].device;
//                     return ListTile(
//                       leading: const Icon(Icons.bluetooth_audio),
//                       title: Text(
//                         device.name.isNotEmpty ? device.name : device.id.id,
//                       ),
//                       subtitle: Text(device.id.id),
//                       onTap: () async {
//                         Navigator.pop(context);

//                         await Future.delayed(const Duration(seconds: 1));

//                         await _connectToDevice(device);
//                       },
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Future<bool> _checkBluetoothAndPermissions() async {
//     // Bluetooth check
//     BluetoothAdapterState state = await FlutterBluePlus.adapterState.first;
//     if (state != BluetoothAdapterState.on) {
//       try {
//         await FlutterBluePlus.turnOn();
//         state = await FlutterBluePlus.adapterState.first;
//         if (state != BluetoothAdapterState.on) {
//           showBluetoothOffDialog(context);
//           return false;
//         }
//       } catch (e) {
//         showBluetoothOffDialog(context);
//         return false;
//       }
//     }

//     // Permission check
//     final permissionStatus = await Permission.location.request();
//     if (!permissionStatus.isGranted) {
//       showLocationPermissionDialog(context);
//       return false;
//     }

//     // Location Services check
//     final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!isLocationEnabled) {
//       showEnableLocationServicesDialog(context);
//       return false;
//     }

//     return true;
//   }

//   Future<void> _connectToDevice(BluetoothDevice device) async {
//     try {
//       await device.disconnect();

//       await device.connect(timeout: const Duration(seconds: 10));

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             'Connected successfully',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.green,
//         ),
//       );

//       List<BluetoothService> services = await device.discoverServices();

//       for (BluetoothService service in services) {
//         for (BluetoothCharacteristic characteristic
//             in service.characteristics) {
//           if (characteristic.properties.notify ||
//               characteristic.properties.indicate) {
//             await characteristic.setNotifyValue(true);
//             characteristic.onValueReceived.listen((value) {
//               String stringValue = String.fromCharCodes(value);

//               setState(() {
//                 receivedValue = stringValue;
//               });

//               debugPrint("Received value: $stringValue");
//             });
//           }
//         }
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Connection failed: $e',
//             style: const TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   String receivedValue = 'No data received yet';

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Form(
//         child: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           child: Column(
//             children: [
//               AppBar(
//                 // leadingWidth: 20.0,
//                 elevation: 0,
//                 backgroundColor: Colors.transparent,
//                 actionsPadding: EdgeInsets.all(0.0),

//                 title: Txt(text: 'Bluetooth Configuration', fontSize: 15.sp),
//                 // backgroundColor: Colors.purple.shade700,
//                 centerTitle: false,
//                 iconTheme: IconThemeData(color: context.inverse),
//               ),

//               const SizedBox(height: 24),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//                 child: AuthCustomButton(
//                   onTap: () async => () {},
//                   text: 'Connect',
//                 ),
//               ),

//               SizedBox(height: 20.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



