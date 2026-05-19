#!/bin/bash
# Verify correct permissions are applied
PASS=true

DIR_PERMS=$(stat -c "%a" /opt/myapp 2>/dev/null)
FILE_PERMS=$(stat -c "%a" /opt/myapp/config.txt 2>/dev/null)
DIR_OWNER=$(stat -c "%U" /opt/myapp 2>/dev/null)
FILE_OWNER=$(stat -c "%U" /opt/myapp/config.txt 2>/dev/null)

if [ "$DIR_PERMS" = "750" ]; then
  echo "✅ Directory /opt/myapp has correct permissions (750)"
else
  echo "❌ Directory /opt/myapp has permissions $DIR_PERMS — expected 750"
  echo "   Run: chmod 750 /opt/myapp"
  PASS=false
fi

if [ "$FILE_PERMS" = "640" ]; then
  echo "✅ Config file has correct permissions (640)"
else
  echo "❌ Config file has permissions $FILE_PERMS — expected 640"
  echo "   Run: chmod 640 /opt/myapp/config.txt"
  PASS=false
fi

if [ "$DIR_OWNER" = "webuser" ]; then
  echo "✅ Directory is owned by webuser"
else
  echo "❌ Directory owner is $DIR_OWNER — expected webuser"
  echo "   Run: chown -R webuser:webuser /opt/myapp"
  PASS=false
fi

# Final confirmation: attacker should be denied
if su - attacker -c "cat /opt/myapp/config.txt" 2>&1 | grep -q "Permission denied"; then
  echo "✅ Attacker correctly denied access to config.txt — least privilege works!"
else
  echo "❌ Attacker can still read config.txt — check permissions and ownership"
  PASS=false
fi

if [ "$PASS" = true ]; then
  exit 0
else
  exit 1
fi
