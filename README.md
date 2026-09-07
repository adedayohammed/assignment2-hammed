# Dockerized Diagnostic CLI Toolkit

A containerized, lightweight diagnostic tool designed to evaluate local system specs and external networks.

## 🚀 Building the Environment

Build the localized Docker image tag manually:
```bash
docker build -t diagnostic-tool .
```

## 🛠️ Execution Manual

### Run with Local Docker CLI
```bash
docker run --rm diagnostic-tool system
docker run --rm diagnostic-tool disk
docker run --rm diagnostic-tool network google.com
docker run --rm diagnostic-tool help
```

### Run with Docker Compose
```bash
docker compose run --rm diagnostic system
docker compose run --rm diagnostic disk
docker compose run --rm diagnostic network google.com
```

## 🧪 Automated Testing

Execute tests to verify exit statuses and outputs:
```bash
chmod +x test.sh grade.sh
./test.sh
./grade.sh
```
