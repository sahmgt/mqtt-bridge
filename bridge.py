import paho.mqtt.client as mqtt
import requests
import os

BROKER = "localhost"
PORT = 10000  # WebSocket порт Render
TOPIC = os.getenv("MQTT_TOPIC", "test/#")
WEBHOOK = os.getenv("WEBHOOK_URL", "https://ntfy.sh/mkhntsmrln1Ht4Wm63QeF9sVx8B")

def on_message(client, userdata, msg):
    payload = msg.payload.decode(errors="ignore")
    print(f"[{msg.topic}] {payload}")
    try:
        requests.post(WEBHOOK, data=payload.encode(), timeout=5)
    except Exception as e:
        print("Помилка надсилання:", e)

def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("✅ Підключено до брокера WebSocket")
        client.subscribe(TOPIC)
    else:
        print(f"❌ Помилка підключення: {rc}")

client = mqtt.Client(transport="websockets")
client.on_message = on_message
client.on_connect = on_connect

print("🔌 Підключення до брокера...")
client.connect(BROKER, PORT, 60)
print("MQTT→HTTPS bridge запущено (WebSocket)")

client.loop_forever()
