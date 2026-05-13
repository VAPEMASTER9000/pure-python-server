#!/bin/sh
# Auto-restart wrapper for THE WEIRD SITE
while true; do
  echo "[$(date)] Starting Weird Site..."
  python server.py
  echo "[$(date)] Server crashed or stopped. Restarting in 3 seconds..."
  sleep 3
done