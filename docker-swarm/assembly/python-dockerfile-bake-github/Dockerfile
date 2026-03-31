# ===== Stage 1: Builder =====
FROM python:3.11-slim as builder

WORKDIR /app

# Кэширование слоя с зависимостями
COPY requirements.txt .
#RUN pip install --user -r requirements.txt

# ===== Stage 2: Runtime =====
FROM python:3.11-slim as runtime

# Метаданные образа
LABEL org.opencontainers.image.source="https://github.com/airatfatikhov"
LABEL org.opencontainers.image.description="Python Hello World Application"
LABEL org.opencontainers.image.licenses="MIT"

# Создаём не-root пользователя для безопасности
RUN useradd --create-home --shell /bin/bash appuser

WORKDIR /app

# Копируем зависимости из builder
#COPY --from=builder /root/.local /home/appuser/.local

# Копируем приложение
COPY app.py .

# Переключаемся на не-root пользователя
USER appuser

# Добавляем локальные бинарники в PATH
ENV PATH=/home/appuser/.local/bin:$PATH
ENV PATH=/root/.local/bin:$PATH

# Команда запуска
CMD ["python", "app.py"]