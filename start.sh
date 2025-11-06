#!/bin/bash
echo "🚀 Запуск Mosquitto..."
mosquitto -c /etc/mosquitto/mosquitto.conf &
sleep 3  # зачекай поки брокер стартує

echo "⚙️  Запуск bridge.py..."
python3 /app/bridge.py &
sleep 3  # дати йому стабілізуватись

echo "🌐 Запуск Cloudflare Tunnel..."
cloudflared tunnel --url http://localhost:10000 --protocol http2
