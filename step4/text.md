# Step 4 — Create User and Application Directory

**Security best practice:** Services should never run as `root` or your personal account. Each service should have its own dedicated **service account** with only the permissions it needs.

## Create a dedicated user

```bash
useradd -m webuser
```{{exec}}

> **Command breakdown:**
> - `useradd` — creates a new user account
> - `-m` — automatically create a **home directory** at `/home/webuser`
> - `webuser` — the name of the new user

Set a password (use `webpass123` for this lab):

```bash
echo "webuser:webpass123" | chpasswd
```{{exec}}

> **`chpasswd`** reads `username:password` pairs from stdin and sets passwords without an interactive prompt — ideal for scripting.

## Create the application directory

```bash
mkdir -p /opt/myapp
```{{exec}}

> **Command breakdown:**
> - `mkdir` — make directory
> - `-p` — create **parent** directories as needed, and don't error if the directory already exists
> - `/opt/myapp` — `/opt` is the conventional Linux location for third-party application files

## Assign ownership to webuser

```bash
chown webuser:webuser /opt/myapp
```{{exec}}

> **`chown user:group path`** — changes the **owner** and **group** of a file or directory. Now `webuser` owns the app folder, not root.

## Create a sensitive config file

This simulates a real application config with secrets — the kind of file that **must** be protected:

```bash
echo "DB_PASSWORD=SuperSecret123" > /opt/myapp/config.txt
echo "API_KEY=abc987xyzTOPSECRET" >> /opt/myapp/config.txt
echo "DB_HOST=prod-db.internal" >> /opt/myapp/config.txt
chown webuser:webuser /opt/myapp/config.txt
```{{exec}}

## Create a second user to simulate an attacker

We'll need this in Steps 5 and 6:

```bash
useradd -m attacker
echo "attacker:attackpass" | chpasswd
```{{exec}}

## Verify the setup

```bash
ls -la /opt/myapp/
id webuser
id attacker
```{{exec}}

> **`ls -la`** shows files with permissions, owner, and group. **`id username`** shows the UID, GID, and group memberships of a user.

---
✅ Click **Continue** once both users and the app directory exist.
