# Step 1 — Run a Web Server

Python 3 ships with a built-in HTTP server module. It requires **zero installation** and serves files from whatever directory you point it at — perfect for demos and local testing.

## Navigate to the web root

First, move into the directory that was set up for you:

```bash
cd /root/webroot
```{{exec}}

## Start the web server

```bash
python3 -m http.server 8080 &
```{{exec}}

> **Command breakdown:**
> - `python3 -m` — run a Python module as a script
> - `http.server` — the built-in web server module
> - `8080` — the port number to listen on (port 80 requires root; 8080 is conventional for dev)
> - `&` — run the process **in the background** so your terminal stays usable

You should see output like:
```
Serving HTTP on 0.0.0.0 port 8080 (http://0.0.0.0:8080/) ...
[1] 12345
```
The number after `[1]` is the **PID** (Process ID) — note it down, you will use it in Step 2.

## Verify the server is responding

```bash
curl http://localhost:8080
```{{exec}}

> **`curl`** is a command-line HTTP client. It sends a request to the server and prints the response. If you see HTML output, your server is live!

---
✅ Click **Continue** once the server is running and curl returns a response.
