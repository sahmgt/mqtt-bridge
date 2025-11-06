#!/bin/bash
echo "🚀 Запуск Mosquitto..."
mosquitto -c /etc/mosquitto/mosquitto.conf &
sleep 3  # трохи зачекати, поки брокер підніметься

echo "⚙️  Запуск bridge.py..."
python3 /app/bridge.py &

sleep 3  # ще трохи для стабільності
echo "🌐 Запуск Cloudflare Tunnel..."
cloudflared tunnel run --token $TUNNEL_TOKEN
