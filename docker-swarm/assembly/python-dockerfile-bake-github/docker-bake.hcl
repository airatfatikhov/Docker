# ===== Переменные =====
variable "IMAGE_NAME" {
  default = "python-hello-docker"
}

variable "GITHUB_USER" {
  default = "airatfatikhov"
}

variable "VERSION" {
  default = "latest"
}

# ===== Группа по умолчанию =====
group "default" {
  targets = ["build"]
}

# ===== Таргет для локальной сборки =====
target "build" {
  context = "."
  dockerfile = "Dockerfile"
  platforms = ["linux/amd64"]
  output = ["type=registry"]
  tags = [
    "ghcr.io/${GITHUB_USER}/${IMAGE_NAME}:${VERSION}"
  ]
}

# ===== Таргет для мульти-архитектуры =====
target "multiarch" {
  context = "."
  dockerfile = "Dockerfile"
  platforms = ["linux/amd64", "linux/arm64"]
  output = ["type=registry"]
  tags = [
    "ghcr.io/${GITHUB_USER}/${IMAGE_NAME}:${VERSION}"
  ]
}

# ===== Таргет для CI/CD (с метаданными) =====
target "ci" {
  context = "."
  dockerfile = "Dockerfile"
  platforms = ["linux/amd64"]
  output = ["type=registry", "push=true"]
  tags = [
    "ghcr.io/${GITHUB_USER}/${IMAGE_NAME}:${VERSION}"
  ]
  # Автоматические метаданные из Git
  annotations = [
    "org.opencontainers.image.source=https://github.com/${GITHUB_USER}/${IMAGE_NAME}",
    "org.opencontainers.image.version=${VERSION}"
  ]
}