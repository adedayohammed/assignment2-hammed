#!/bin/bash

COMMAND="$1"
ARG="$2"

case "$COMMAND" in
    system)
        echo "=== SYSTEM INFORMATION ==="
        echo "Hostname:     $(hostname)"
        echo "Current User: $(whoami)"
        echo "Date/Time:    $(date)"
        echo "OS/Kernel:    $(uname -sr)"
        echo "Uptime:       $(uptime -p)"
        echo "Memory:       $(free -h | awk '/^Mem:/ {print $3 "/" $2}')"
        ;;
    network)
        if [ -z "$ARG" ]; then
            echo "Error: Missing host argument for network check." >&2
            echo "Usage: diagnostic network <host>" >&2
            exit 2
        fi
        echo "=== NETWORK CHECK ==="
        echo "Resolving $ARG..."
        if ! IP=$(dig +short "$ARG" | tail -n1) || [ -z "$IP" ]; then
            IP=$(getent hosts "$ARG" | awk '{print $1}')
        fi
        
        if [ -z "$IP" ]; then
            echo "Error: Could not resolve host '$ARG'" >&2
            exit 1
        fi
        echo "Resolved IP: $IP"
        
        if ping -c 2 "$IP" > /dev/null 2>&1; then
            echo "Ping Status: SUCCESS"
        else
            echo "Ping Status: FAILED"
            exit 1
        fi
        ;;
    disk)
        echo "=== DISK INFORMATION ==="
        df -h /
        ;;
    help|--help|-h)
        echo "Usage: diagnostic <command> [argument]"
        echo ""
        echo "Commands:"
        echo "  system          Display useful Linux system information."
        echo "  network <host>  Check connectivity to the supplied host."
        echo "  disk            Display disk space information."
        echo "  help            Display this help usage manual."
        ;;
    "")
        echo "Error: No command provided." >&2
        echo "Use 'diagnostic help' for syntax layout." >&2
        exit 2
        ;;
    *)
        echo "Error: Invalid command '$COMMAND'." >&2
        echo "Use 'diagnostic help' for syntax layout." >&2
        exit 2
        ;;
esac

exit 0
