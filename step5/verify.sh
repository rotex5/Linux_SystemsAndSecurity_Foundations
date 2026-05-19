#!/bin/bash
# Verify that 777 permissions are set on /opt/myapp and config.txt
DIR_PERMS=$(stat -c "%a" /opt/myapp 2>/dev/null)
FILE_PERMS=$(stat -c "%a" /opt/myapp/config.txt 2>/dev/null)

if [ "$DIR_PERMS" = "777" ] && [ "$FILE_PERMS" = "777" ]; then
  echo "✅ Permissions are set to 777 on both the directory and config file."
  exit 0
else
  echo "❌ Permissions not set correctly."
  echo "   /opt/myapp is: $DIR_PERMS (needs 777)"
  echo "   /opt/myapp/config.txt is: $FILE_PERMS (needs 777)"
  echo "   Run: chmod 777 /opt/myapp && chmod 777 /opt/myapp/config.txt"
  exit 1
fi
