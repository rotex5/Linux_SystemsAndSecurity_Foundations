#!/bin/bash
# Verify the server was restarted and is running again
if pgrep -f "http.server" > /dev/null; then
  echo "✅ Server is running again with PID: $(pgrep -f http.server)"
  exit 0
else
  echo "❌ Server is not running. Restart it with: cd /root/webroot && python3 -m http.server 8080 &"
  exit 1
fi
