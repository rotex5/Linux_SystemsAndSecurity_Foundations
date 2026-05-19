# Step 5 — Misconfigure Permissions ⚠️

In this step we are going to **intentionally make a mistake** — one that is surprisingly common in real-world systems. This is so you can clearly see what goes wrong and why it matters.

## Understanding Linux permissions

Every file and directory has a 3-part permission set:

```
  Owner    Group    Others
  r w x    r w x    r w x
  4 2 1    4 2 1    4 2 1
```

Each digit in `chmod` is the **sum** of permissions for that group:
- `7` = 4+2+1 = read + write + execute (full access)
- `6` = 4+2+0 = read + write
- `5` = 4+0+1 = read + execute
- `4` = 4+0+0 = read only
- `0` = no permissions at all

## Check the current (correct) permissions

```bash
ls -la /opt/myapp/
```{{exec}}

You should see something like `drwxr-xr-x` or similar. The `d` means directory, followed by permissions for owner, group, and others.

## Apply the dangerous misconfiguration

```bash
chmod 777 /opt/myapp
chmod 777 /opt/myapp/config.txt
```{{exec}}

> **What `chmod 777` means:**
> - Owner: `rwx` — read, write, execute ✅
> - Group: `rwx` — read, write, execute ⚠️
> - Others: `rwx` — read, write, execute ❌ **EVERYONE on the system**
>
> This means **any user, any process, any account** that exists on this machine can read, modify, or delete these files. This includes compromised accounts, guest users, and other services.

## Verify the bad permissions are set

```bash
ls -la /opt/myapp/
```{{exec}}

You should now see `drwxrwxrwx` for the directory and `-rwxrwxrwx` for the config file. That last trio of `rwx` is the problem — it's the permissions for **"everyone else"** on the system.

---
✅ Click **Continue** once you can see the `777` permissions in place.
