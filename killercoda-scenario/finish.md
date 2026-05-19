# 🎉 Lab Complete — Well Done!

You have successfully completed the **System Control & Security Lab**. Here is a summary of everything you practised:

---

## What You Accomplished

| Step | What You Did | Key Command |
|------|-------------|-------------|
| 1 | Deployed a Python web server | `python3 -m http.server 8080 &` |
| 2 | Inspected the process and port | `ps aux`, `ss -tlnp`, `top -p` |
| 3 | Killed and restarted the process | `kill`, `kill -9`, `pkill` |
| 4 | Created a service user and app directory | `useradd -m`, `mkdir -p`, `chown` |
| 5 | Applied a dangerous misconfiguration | `chmod 777` |
| 6 | Demonstrated the full attack surface | `su - attacker`, `cat`, `echo >>`, `rm` |
| 7 | Fixed it with least privilege | `chmod 750`, `chmod 640`, `chown -R` |

---

## Key Security Takeaways

🔍 **Know your processes** — Every service has a PID, an owner, and a resource footprint. Always know what is running on your system.

⚙️ **SIGTERM before SIGKILL** — Always try a graceful stop first. Force kill only when necessary.

👤 **Dedicated service accounts** — Never run applications as root or your personal account. Create a purpose-built user for each service.

🔐 **Least Privilege** — Grant only the permissions a user or process actually needs:
- `600` — secret files (owner read/write only)
- `640` — app configs (owner rw, group read)
- `750` — app directories (owner full, group r+x)
- `755` — public directories and executables
- `777` — **never in production**

---

## Quick Reference

```bash
# Permissions cheat sheet
chmod 600 file   # Owner read/write only — for private keys
chmod 640 file   # Owner rw, group read — for app configs
chmod 750 dir    # Owner full, group r+x — for app directories
chmod 755 dir    # Standard public directory

# Ownership
chown user:group file     # Change owner and group
chown -R user:group dir   # Change recursively

# Process control
kill PID         # Graceful (SIGTERM)
kill -9 PID      # Force (SIGKILL)
pkill -f name    # Kill by name pattern

# Inspection
ps aux | grep name   # Find a process
ss -tlnp             # List listening ports
top -p PID           # Watch a specific process
```

---

> **Keep practising!** The best way to build confidence with Linux is hands-on repetition. Try creating additional users, directories, and permission combinations to see how they interact.
