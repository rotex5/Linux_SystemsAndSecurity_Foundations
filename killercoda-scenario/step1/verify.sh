#!/bin/bash
# Verify that python3 http.server is running on port 8080
if pgrep -f "http.server" > /dev/null; then
  echo "✅ Web server is running!"
  exit 0
else
  echo "❌ Web server not found. Make sure you ran: python3 -m http.server 8080 &"
  exit 1
fi
