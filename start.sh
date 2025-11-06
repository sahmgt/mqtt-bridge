#!/bin/bash
# Запускаємо healthcheck одразу
python3 /app/healthcheck.py &
echo "Healthcheck HTTP running on port 10000"

# Чекаємо 10 секунд — Render визначить вебпорт
sleep 10

# Тепер запускаємо Mosquitto
mosquitto -c /etc/mosquitto/mosquitto.conf &
echo "Mosquitto started on port 1883"

# Ще трохи пауза для стабільності
sleep 3

# Запускаємо bridge
python3 /app/bridge.py
