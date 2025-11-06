FROM python:3.11-slim

# Встановлюємо Mosquitto
RUN apt-get update && \
    apt-get install -y mosquitto mosquitto-clients && \
    rm -rf /var/lib/apt/lists/*

# Встановлюємо Python залежності
COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Копіюємо файли
WORKDIR /app
COPY mosquitto.conf /etc/mosquitto/mosquitto.conf
COPY bridge.py /app/bridge.py
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# WebSocket порт Render
ENV PORT=10000
EXPOSE 10000
# Встановлюємо Cloudflare Tunnel
RUN apt-get update && apt-get install -y curl
RUN curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o /usr/local/bin/cloudflared
RUN chmod +x /usr/local/bin/cloudflared
CMD ["/app/start.sh"]
