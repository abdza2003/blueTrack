import 'package:bluetrack/core/components/custom_scaffold.dart';
import 'package:bluetrack/core/components/txt.dart';
import 'package:flutter/material.dart';
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
  String imageUrl = 'https://cdn-icons-png.flaticon.com/512/1995/1995574.png';

  @override
  void initState() {
    super.initState();
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
        imageUrl = getImage(cleanPayload);
      });
    });
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Txt(
              text: activity.toUpperCase(),
              // style: const TextStyle(
              fontSize: 26,
              // color: Colors.white,
              fontWeight: FontWeight.bold,
              // ),
            ),
            const SizedBox(height: 20),
            Image.network(imageUrl, height: 150),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text('Back'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: disconnectClient,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Disconnect'),
            ),
          ],
        ),
      ),
    );
  }
}
