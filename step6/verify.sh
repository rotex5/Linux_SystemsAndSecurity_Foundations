#!/bin/bash
# Verify attacker was able to modify or delete the config file (proving the risk)
# We check that we are back as root and the damage was done

CURRENT_USER=$(whoami)

if [ "$CURRENT_USER" = "root" ]; then
  echo "✅ Back to root — attack demonstration complete."
  # Check that tampering happened (file modified or deleted)
  if [ ! -f /opt/myapp/config.txt ] || grep -q "BACKDOOR" /opt/myapp/config.txt 2>/dev/null; then
    echo "✅ Evidence of access risk confirmed (file was modified or deleted by attacker)."
  else
    echo "⚠️  Try completing all three attacks (read, modify, delete) before continuing."
  fi
  exit 0
else
  echo "❌ You are still logged in as '$CURRENT_USER'. Type 'exit' to return to root first."
  exit 1
fi
