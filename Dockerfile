# Используем официальный Python образ
FROM python:3.11-slim

# Устанавливаем рабочую директорию
WORKDIR /app

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Копируем файл зависимостей
COPY requirements.txt .

# Устанавливаем Python зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Копируем код приложения
COPY code/ ./code/
COPY data/ ./data/

# Создаем директории для базы данных
RUN mkdir -p db

# Устанавливаем рабочую директорию для запуска
WORKDIR /app/code

# Открываем порт (если потребуется для мониторинга)
EXPOSE 8000

# Команда запуска
CMD ["python", "bot.py"]

