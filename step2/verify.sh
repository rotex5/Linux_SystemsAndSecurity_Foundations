#!/bin/bash
# Verify the server is still running and port 8080 is active
if ss -tlnp | grep -q ":8080"; then
  echo "✅ Port 8080 is active and the server is listening."
  exit 0
else
  echo "❌ Port 8080 is not active. Is the server still running?"
  exit 1
fi
