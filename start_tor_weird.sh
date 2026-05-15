#/bin/ash
# THE WEIRD TOR HIDDEN SERVICE

echo "=== THE WEIRD TOR ONION SITE ==="
echo "Installing/Checking Tor..."

# Start Tor in background
pkill tor 2>/dev/null || true
tor --daemon --quiet
sleep 3

# Create Tor hidden service config if not exists
mkdir -p /etc/tor
cat > /etc/tor/torrc << EOF
HiddenServiceDir /root/.tor/hidden_service
HiddenServicePort 80 127.0.0.1:8000
EOF

# Start the Python server in background
cd /root/pure-python-server
python server.py > server.log 2>&1 &

sleep 5

# Show onion address
echo "
=== YOUR ONION URL ==="
if [ -f /root/.tor/hidden_service/hostname ]; then
  cat /root/.tor/hidden_service/hostname
else
  echo "Waiting for Tor... check again in 30 seconds"
fi

echo "
Site running! Open Tor Browser and visit the .onion address above."
echo "Press Ctrl+C to stop."

# Keep script running
while true; do
  sleep 30
done