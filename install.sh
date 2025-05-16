#!/bin/bash

set -e

REPO_URL="https://raw.githubusercontent.com/abkarada/SystemSaver/main"
SCRIPT_NAME="SystemSaver.sh"

echo "[INFO] Downloading SystemSaver..."
curl -fsSL "$REPO_URL/$SCRIPT_NAME" -o "$SCRIPT_NAME"
chmod +x "$SCRIPT_NAME"

echo "[SUCCESS] SystemSaver installed locally as ./$SCRIPT_NAME"
echo "[INFO] To run the recovery script, type:"
echo "         ./SystemSaver.sh"

