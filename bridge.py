import paho.mqtt.client as mqtt
import requests
import os

BROKER = "localhost"
PORT = 1883
TOPIC = os.getenv("MQTT_TOPIC", "test/#")
WEBHOOK = os.getenv("WEBHOOK_URL", "https://ntfy.sh/mkhntsmrln1Ht4Wm63QeF9sVx8B")

def on_message(client, userdata, msg):
    payload = msg.payload.decode(errors="ignore")
    print(f"[{msg.topic}] {payload}")
    try:
        requests.post(WEBHOOK, data=payload.encode(), timeout=5)
    except Exception as e:
        print("Помилка надсилання:", e)

client = mqtt.Client()
client.on_message = on_message
client.connect(BROKER, PORT, 60)
client.subscribe(TOPIC)

print("MQTT→HTTPS bridge запущено")
client.loop_forever()
