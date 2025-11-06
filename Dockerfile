# 🧱 Базовий образ
FROM python:3.10-slim

# 🕓 Робоча директорія
WORKDIR /app

# 🧩 Встановлюємо залежності системи
RUN apt-get update && apt-get install -y \
    mosquitto \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 🐍 Встановлюємо Python-залежності
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 📁 Копіюємо усі файли застосунку
COPY . .

# 🔧 Дозвіл на виконання скриптів
RUN chmod +x start.sh

# 🌐 Встановлюємо Cloudflare Tunnel
RUN curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o /usr/local/bin/cloudflared \
    && chmod +x /usr/local/bin/cloudflared

# 🔊 Відкриваємо потрібні порти
EXPOSE 1883
EXPOSE 10000

# 🚀 Команда запуску
CMD ["bash", "start.sh"]
