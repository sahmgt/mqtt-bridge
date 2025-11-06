#!/bin/bash
echo "Запуск Mosquitto..."
mosquitto -c /etc/mosquitto/mosquitto.conf &

echo "Запуск bridge.py..."
python3 /app/bridge.py &

echo "Очікування 3 секунди для стабілізації..."
sleep 3

echo "Запуск Cloudflare Tunnel..."
cloudflared tunnel --url http://localhost:10000
