## 📁 Структура проекта
````
python-hello-docker/
├── app.py
├── requirements.txt
├── Dockerfile
├── docker-bake.hcl
├── .dockerignore
└── README.md
````
## 1️⃣ Приложение (app.py)
````
#!/usr/bin/env python3
"""Простое Hello World приложение"""

def main():
    print("🐍 Hello from Python Docker!")
    print(f"📦 Приложение успешно запущено в контейнере")

if __name__ == "__main__":
    main()
````

## 2️⃣ Зависимости (requirements.txt)
````
# Пустой файл, если нет внешних зависимостей
# Или добавьте нужные пакеты:
# requests==2.31.0
````
## 3️⃣ Dockerfile (Многоэтапная сборка)

## 4️⃣ Docker Bake (docker-bake.hcl)

## 5️⃣ .dockerignore

## 6️⃣ Пошаговая инструкция

### 🔹 Шаг 1: Логин в GitHub Registry
````
# Создайте Personal Access Token в GitHub:
# Settings → Developer settings → Personal access tokens → Classic
# Права: write:packages, read:packages

# Логин
echo $GITHUB_TOKEN | docker login ghcr.io -u YOUR_USERNAME --password-stdin
````

### 🔹 Шаг 2: Локальная сборка (тест)
````
# Сборка через bake (таргет "build" по умолчанию)
docker buildx bake

# Или явно указать таргет
docker buildx bake build

# Проверка образа
docker images | grep python-hello-docker

# Запуск
docker run --rm python-hello-docker:latest
````

### 🔹 Шаг 3: Сборка и пуш в GHCR
````
# Пуш одного образа (amd64)
docker buildx bake --push build

# Пуш мульти-архитектурного образа (amd64 + arm64)
docker buildx bake --push multiarch

# Или через таргет ci
docker buildx bake --push ci
````

### 🔹 Шаг 4: Проверка в Registry

````
# Проверка конфигурации bake
docker buildx bake --print

# Просмотр доступных таргетов
docker buildx bake --list

# Сборка без пуша (тест)
docker buildx bake --load

# Принудительная пересборка без кэша
docker buildx bake --no-cache --push

# Проверка образа после pull
docker inspect ghcr.io/YOUR_USERNAME/python-hello-docker:latest
````

### 9️⃣ Проверка и отладка
````
# Проверка конфигурации bake
docker buildx bake --print

# Просмотр доступных таргетов
docker buildx bake --list

# Сборка без пуша (тест)
docker buildx bake --load

# Принудительная пересборка без кэша
docker buildx bake --no-cache --push

# Проверка образа после pull
docker inspect ghcr.io/YOUR_USERNAME/python-hello-docker:latest
````