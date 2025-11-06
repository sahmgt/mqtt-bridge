#!/bin/bash
mosquitto -c /etc/mosquitto/mosquitto.conf &
sleep 3
python3 /app/bridge.py
