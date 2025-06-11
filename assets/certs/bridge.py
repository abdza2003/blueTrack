import time
from AWSIoTPythonSDK.MQTTLib import AWSIoTMQTTClient

client_id = "ActivityRecDevice"
endpoint = "a18806peqaso3-ats.iot.eu-north-1.amazonaws.com"
port = 8883
topic = "person/activity"

root_ca_path = "D:\\Cloud ActivityRec\\AmazonRootCA1.pem"
private_key_path = "D:\\Cloud ActivityRec\\1f517192598cbed5c547cb2b5b38eb14f31fe1aa33f4c1d7084057a348c18eb5-private.pem.key"
certificate_path = "D:\\Cloud ActivityRec\\1f517192598cbed5c547cb2b5b38eb14f31fe1aa33f4c1d7084057a348c18eb5-certificate.pem.crt"

mqtt_client = AWSIoTMQTTClient(client_id)
mqtt_client.configureEndpoint(endpoint, port)
mqtt_client.configureCredentials(root_ca_path, private_key_path, certificate_path)

mqtt_client.configureOfflinePublishQueueing(-1)
mqtt_client.configureDrainingFrequency(2)
mqtt_client.configureConnectDisconnectTimeout(10)
mqtt_client.configureMQTTOperationTimeout(5)

print("Connecting...")
mqtt_client.connect()
print("Connected!")

# Send every 3 seconds
activities = ['walking', 'running', 'sitting', 'standing']

while True:
    for activity in activities:
        print(f"Publishing: {activity}")
        mqtt_client.publish(topic, activity, 1)
        time.sleep(3)
