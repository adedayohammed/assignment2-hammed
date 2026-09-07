#!/bin/bash
IMAGE_NAME="diagnostic-tool:latest"

echo "Running Test Suites on $IMAGE_NAME..."
echo "----------------------------------------"

# 1. Test Help Command
echo -n "Test [help]: "
docker run --rm $IMAGE_NAME help | grep -q "Usage: diagnostic" && echo "PASS" || echo "FAIL"

# 2. Test System Command
echo -n "Test [system]: "
docker run --rm $IMAGE_NAME system | grep -q "=== SYSTEM INFORMATION ===" && echo "PASS" || echo "FAIL"

# 3. Test Disk Command
echo -n "Test [disk]: "
docker run --rm $IMAGE_NAME disk | grep -q "=== DISK INFORMATION ===" && echo "PASS" || echo "FAIL"

# 4. Test Invalid Command Error Codes
echo -n "Test [invalid command exit code]: "
docker run --rm $IMAGE_NAME fakecommand >/dev/null 2>&1
if [ $? -eq 2 ]; then echo "PASS"; else echo "FAIL"; fi

# 5. Test Missing Network Argument Error Codes
echo -n "Test [network missing args exit code]: "
docker run --rm $IMAGE_NAME network >/dev/null 2>&1
if [ $? -eq 2 ]; then echo "PASS"; else echo "FAIL"; fi
