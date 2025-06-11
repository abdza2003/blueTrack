import 'package:bluetrack/core/components/custom_scaffold.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/constants/space_constant.dart';
import 'package:bluetrack/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ActivityMonitorPage extends StatefulWidget {
  final String broker;
  final String topic;

  const ActivityMonitorPage({
    super.key,
    required this.broker,
    required this.topic,
  });

  @override
  State<ActivityMonitorPage> createState() => _ActivityMonitorPageState();
}

class _ActivityMonitorPageState extends State<ActivityMonitorPage> {
  late MqttServerClient client;
  String activity = 'Waiting...';
  dynamic info;

  @override
  void initState() {
    super.initState();

    info = getImage('nothing');

    connectToBroker();
  }

  Future<String> copyAsset(String assetPath, String filename) async {
    final byteData = await rootBundle.load(assetPath);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file.path;
  }

  void connectToBroker() async {
    client = MqttServerClient.withPort(
      widget.broker,
      'flutter_subscriber_${DateTime.now().millisecondsSinceEpoch}',
      8883,
    );
    client.secure = true;
    client.logging(on: true);
    client.keepAlivePeriod = 20;

    try {
      final caPath = await copyAsset(
        'assets/certs/AmazonRootCA1.pem',
        'ca.pem',
      );
      final certPath = await copyAsset(
        'assets/certs/1f517192598cbed5c547cb2b5b38eb14f31fe1aa33f4c1d7084057a348c18eb5-certificate.pem.crt',
        'cert.pem',
      );
      final keyPath = await copyAsset(
        'assets/certs/1f517192598cbed5c547cb2b5b38eb14f31fe1aa33f4c1d7084057a348c18eb5-private.pem.key',
        'key.pem',
      );

      final context = SecurityContext.defaultContext;
      context.setTrustedCertificates(caPath);
      context.useCertificateChain(certPath);
      context.usePrivateKey(keyPath);
      client.securityContext = context;
    } catch (e) {
      showMsg('❌ Certificate error: $e');
      return;
    }

    final connMess = MqttConnectMessage()
        .withClientIdentifier('flutter_subscriber')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    client.connectionMessage = connMess;

    try {
      await client.connect();
      showMsg('🟢 Connected to AWS IoT');
    } catch (e) {
      showMsg('❌ Connection failed: $e');
      client.disconnect();
      return;
    }

    client.subscribe(widget.topic, MqttQos.atMostOnce);

    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> events) {
      final msg = events[0].payload as MqttPublishMessage;
      final payload = MqttPublishPayload.bytesToStringAsString(
        msg.payload.message,
      );
      final cleanPayload = payload.trim().toLowerCase();

      setState(() {
        activity = cleanPayload;
        info = getImage(cleanPayload);
      });
    });
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

  void showMsg(String text) {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text), backgroundColor: Colors.green),
      );
    });
  }

  void disconnectClient() {
    client.disconnect();
    showMsg('🔌 Disconnected');
  }

  @override
  Widget build(BuildContext context) {
    info = getImage(activity);

    return CustomScaffold(
      title: 'Activity Monitor',
      // backgroundColor: Colors.black,
      // appBar: AppBar(
      //   backgroundColor: Colors.purple.shade700,
      //   title: const Text('Activity Monitor'),
      //   centerTitle: true,
      // ),
      child: Center(
        child: Column(
          children: [
            SpaceConstant.instance.heightXXLarge,
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
            // Txt(
            //   text: activity.toUpperCase(),
            //   // style: const TextStyle(
            //   fontSize: 26,
            //   // color: Colors.white,
            //   fontWeight: FontWeight.bold,
            //   // ),
            // ),
            // const SizedBox(height: 20),
            // Image.network(imageUrl, height: 150),
            // const SizedBox(height: 30),
            // ElevatedButton(
            //   onPressed: () => Navigator.pop(context),
            //   style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            //   child: const Text('Back'),
            // ),
            SpaceConstant.instance.heightMedium,
            ElevatedButton(
              onPressed: disconnectClient,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Txt(text: 'Disconnect', color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
