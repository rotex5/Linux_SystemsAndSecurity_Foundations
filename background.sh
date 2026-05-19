#!/bin/bash
# Background setup — runs silently while the intro loads

# Ensure a working directory exists
mkdir -p /root/webroot
echo "<h1>Welcome to the Security Lab</h1>" > /root/webroot/index.html
echo "<p>This server is running as part of the System Control and Security Lab.</p>" >> /root/webroot/index.html

# Pre-create a note file so ps/curl has something to show
echo "Lab environment ready." > /root/webroot/readme.txt
