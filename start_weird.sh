# !/bin/sh
# THE WEIRD SITE - All-in-one for iSH only
# Server + Tunnel combined

echo "
=== THE WEIRD HACKABLE SITE ===
Persistence: Location Heartbeat Active
"

# Background persistence trick
nohup cat /dev/location > /dev/null 2>&1 & 

while true; do
  echo "[$(date)] Starting Weird Server + Tunnel..."
  python server.py &
  SERVER_PID=$!
  
  echo "Attempting Serveo tunnel..."
  ssh -R 80:localhost:8000 serveo.net
  
  echo "[$(date)] Connection dropped. Restarting in 5s..."
  kill $SERVER_PID 2>/dev/null
  sleep 5
done