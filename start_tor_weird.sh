#!/bin/ash
# THE WEIRD TOR HIDDEN SERVICE - Fixed for iSH Alpine Tor 0.4.5

echo "=== THE WEIRD TOR ONION SITE ==="
echo "Installing/Checking Tor..."

# Kill any existing Tor
pkill tor 2>/dev/null || true

# Create clean torrc (no Daemon)
mkdir -p /etc/tor
cat > /etc/tor/torrc << EOF
HiddenServiceDir /root/.tor/hidden_service
HiddenServicePort 80 127.0.0.1:8000
EOF

# Start Tor in background
nohup tor -f /etc/tor/torrc > tor.log 2>&1 &

sleep 6

# Start the weird Python server
cd /root/pure-python-server
python server.py > server.log 2>&1 &

sleep 10

# Show onion address
echo "
=== YOUR ONION URL ==="
if [ -f /root/.tor/hidden_service/hostname ]; then
  echo "http://$(cat /root/.tor/hidden_service/hostname)"
  echo "
Copy the full .onion address and open in Tor Browser."
else
  echo "Waiting for Tor hidden service... (30-90 seconds)"
fi

echo "
Site running on http://localhost:8000"
echo "Press Ctrl+C to stop."

# Keep script alive
while true; do
  sleep 30
done