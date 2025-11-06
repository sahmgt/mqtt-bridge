FROM python:3.11-slim

RUN apt-get update && apt-get install -y mosquitto mosquitto-clients && rm -rf /var/lib/apt/lists/*
COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt

WORKDIR /app
COPY mosquitto.conf /etc/mosquitto/mosquitto.conf
COPY bridge.py /app/bridge.py
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 1883
CMD ["/app/start.sh"]
