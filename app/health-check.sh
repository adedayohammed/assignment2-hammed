#!/bin/bash
if [ -f "/app/diagnostic.sh" ] && [ -x "/app/diagnostic.sh" ]; then
    echo "Health Check: Core CLI binary is healthy."
    exit 0
else
    echo "Health Check: ERROR - CLI missing or lacks execution bit." >&2
    exit 1
fi
