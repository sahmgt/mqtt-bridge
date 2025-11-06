#!/bin/bash
# Спочатку запускаємо healthcheck-сервер
python3 /app/healthcheck.py &

# Даємо Render'у побачити HTTP порт 10000
sleep 5

# Тепер запускаємо MQTT брокер
mosquitto -c /etc/mosquitto/mosquitto.conf &

# І трохи пізніше сам bridge
sleep 3
python3 /app/bridge.py
