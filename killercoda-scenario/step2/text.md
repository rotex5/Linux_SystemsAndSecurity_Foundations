# Step 2 — Analyze PID and Resource Usage

Now that the server is running, let's inspect it as a system process. Linux gives you several powerful tools for this.

## Find the process with `ps`

```bash
ps aux | grep http.server
```{{exec}}

> **Command breakdown:**
> - `ps` — process status; shows running processes
> - `a` — show processes from **all users** (not just yours)
> - `u` — display in **user-readable** format (shows username, CPU%, MEM%, etc.)
> - `x` — include **background** processes (ones not attached to a terminal)
> - `|` — **pipe**: sends the output of `ps aux` into the next command
> - `grep http.server` — filter lines that contain the text "http.server"

The output columns mean: `USER  PID  %CPU  %MEM  VSZ  RSS  STAT  COMMAND`

Note your PID from the output (second column). Store it in a variable for convenience:

```bash
SERVER_PID=$(pgrep -f "http.server")
echo "Server PID is: $SERVER_PID"
```{{exec}}

## Monitor live resource usage with `top`

```bash
top -b -n 1 -p $SERVER_PID
```{{exec}}

> **Command breakdown:**
> - `top` — real-time process viewer (like Task Manager on Linux)
> - `-b` — batch mode (non-interactive, good for scripting)
> - `-n 1` — run only 1 iteration then exit
> - `-p $SERVER_PID` — watch **only** this specific process

## Confirm the port is in use

```bash
ss -tlnp | grep 8080
```{{exec}}

> **Command breakdown:**
> - `ss` — socket statistics (modern replacement for `netstat`)
> - `-t` — show TCP connections only
> - `-l` — show listening sockets only
> - `-n` — show port numbers, not service names
> - `-p` — show which process owns each socket
> - `| grep 8080` — filter for port 8080

You should see your python3 process listed as the owner of port 8080.

---
✅ Click **Continue** once you have identified the PID and confirmed port 8080 is in use.
