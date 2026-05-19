# Step 3 — Kill and Restart the Process

Managing process lifecycles is a fundamental sysadmin skill. Linux uses **signals** to communicate with processes. The two most important are SIGTERM and SIGKILL.

## Get the PID

```bash
SERVER_PID=$(pgrep -f "http.server")
echo "PID to kill: $SERVER_PID"
```{{exec}}

## Graceful stop — SIGTERM (Signal 15)

```bash
kill $SERVER_PID
```{{exec}}

> **What this does:** Sends **SIGTERM** (signal 15) to the process. This is a polite request — it tells the process "please stop when you're ready." The process can finish handling any current request and clean up open files before exiting. This is always the right first choice.

Confirm it stopped:

```bash
pgrep -f "http.server" && echo "Still running" || echo "Process stopped ✅"
```{{exec}}

## Force kill — SIGKILL (Signal 9)

If a process ignores SIGTERM, you escalate to SIGKILL. Let's start a new server and then force-kill it:

```bash
python3 -m http.server 8080 &
sleep 1
NEW_PID=$(pgrep -f "http.server")
echo "New PID: $NEW_PID"
kill -9 $NEW_PID
```{{exec}}

> **What this does:** Sends **SIGKILL** (signal 9). The operating system immediately terminates the process with no cleanup. The process has no chance to respond. Use this only when SIGTERM fails.

## Kill by name with `pkill`

```bash
# Start the server again first
python3 -m http.server 8080 &
sleep 1

# Kill by process name pattern (no PID needed)
pkill -f "http.server"
```{{exec}}

> **`pkill -f "pattern"`** searches the full command line of all processes and kills any that match the pattern. Useful when you don't want to look up the PID first.

## Restart the server

```bash
cd /root/webroot && python3 -m http.server 8080 &
sleep 1
echo "New server PID: $(pgrep -f 'http.server')"
```{{exec}}

> Notice the new PID is a different number — this proves it's a **fresh process**, not the old one recovered.

---
✅ Click **Continue** once you have restarted the server successfully.
