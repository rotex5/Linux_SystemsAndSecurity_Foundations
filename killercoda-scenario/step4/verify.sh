#!/bin/bash
# Verify users and app directory exist
PASS=true

if id webuser &>/dev/null; then
  echo "✅ User 'webuser' exists"
else
  echo "❌ User 'webuser' not found. Run: useradd -m webuser"
  PASS=false
fi

if id attacker &>/dev/null; then
  echo "✅ User 'attacker' exists"
else
  echo "❌ User 'attacker' not found. Run: useradd -m attacker && echo 'attacker:attackpass' | chpasswd"
  PASS=false
fi

if [ -f /opt/myapp/config.txt ]; then
  echo "✅ Config file exists at /opt/myapp/config.txt"
else
  echo "❌ Config file not found at /opt/myapp/config.txt"
  PASS=false
fi

if [ "$PASS" = true ]; then
  exit 0
else
  exit 1
fi
