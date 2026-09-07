#!/bin/bash
echo "Commencing automated evaluation grading routine..."
echo "=================================================="

# Build Image
docker build -t diagnostic-tool:latest . > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "GRADE: 0/100 - Docker build failed entirely."
    exit 1
fi

# Basic functional checks using test script
./test.sh | grep -q "FAIL"
if [ $? -eq 0 ]; then
    echo "GRADE: 50/100 - Code runs but fails target assertions."
else
    echo "GRADE: 100/100 - All functional specification constraints cleared cleanly."
fi
