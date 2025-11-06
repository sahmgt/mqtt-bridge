FROM python:3.11-slim

# Встановлюємо Mosquitto
RUN apt-get update && \
    apt-get install -y mosquitto mosquitto-clients && \
    rm -rf /var/lib/apt/lists/*

# Встановлюємо Python залежності
COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Копіюємо файли застосунку
WORKDIR /app
COPY mosquitto.conf /etc/mosquitto/mosquitto.conf
COPY bridge.py /app/bridge.py
COPY healthcheck.py /app/healthcheck.py
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Render очікує, що сервіс слухає HTTP-порт -> 10000
ENV PORT=10000

# Експонуємо обидва порти: HTTP (для Render) і MQTT
EXPOSE 10000

CMD ["/app/start.sh"]
