#!/bin/bash
# Запускаємо Mosquitto через WebSocket
mosquitto -c /etc/mosquitto/mosquitto.conf &
echo "🌀 Mosquitto WebSocket на порті 10000"

# Коротка затримка для стабільності
sleep 3

# Запускаємо bridge
python3 /app/bridge.py
