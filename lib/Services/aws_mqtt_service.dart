import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class AwsMqttService {
  late MqttServerClient client;
  final String broker = 'YOUR-ENDPOINT.iot.YOUR-REGION.amazonaws.com';
  final String topic = 'person/activity';

  AwsMqttService() {
    client = MqttServerClient.withPort(broker, 'flutter-client-id', 443);
    client.useWebSocket = true;
    client.logging(on: false);
    client.keepAlivePeriod = 20;

    final connMess = MqttConnectMessage()
        .withClientIdentifier(
          'flutter-client-${DateTime.now().millisecondsSinceEpoch}',
        )
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    client.connectionMessage = connMess;
  }

  Future<void> connect() async {
    try {
      await client
          .connect(); // No credentials for now – assumes AWS policy allows unauthenticated WebSocket (IAM not supported directly)
      print('✅ Connected to AWS IoT');

      client.subscribe(topic, MqttQos.atMostOnce);
      client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> events) {
        final recMess = events[0].payload as MqttPublishMessage;
        final payload = MqttPublishPayload.bytesToStringAsString(
          recMess.payload.message,
        );
        print('🔔 Received: $payload');
        // هنا يمكنك إرسال النشاط للتطبيق أو عبر callback
      });
    } catch (e) {
      print('❌ Connection failed: $e');
      disconnect();
    }
  }

  void disconnect() {
    client.disconnect();
    print('🔌 Disconnected');
  }

  void publish(String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
  }
}
