#!/bin/bash

set -e

if [ ! -f SystemSaver.sh ]; then
  echo "[ERROR] SystemSaver.sh not found. Run ./install.sh first or download the script manually."
  exit 1
fi

./SystemSaver.sh

