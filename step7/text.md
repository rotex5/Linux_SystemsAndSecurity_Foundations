# Step 7 — Apply Least Privilege 🔐

The **Principle of Least Privilege** means: grant only the minimum permissions required for a user or process to do its job — nothing more.

## Restore the deleted config file

The attacker deleted it in Step 6. Let's recreate it:

```bash
echo "DB_PASSWORD=SuperSecret123" > /opt/myapp/config.txt
echo "API_KEY=abc987xyzTOPSECRET" >> /opt/myapp/config.txt
echo "DB_HOST=prod-db.internal" >> /opt/myapp/config.txt
```{{exec}}

## Fix the directory permissions

```bash
chmod 750 /opt/myapp
```{{exec}}

> **`750` breakdown:**
> - Owner (`7` = `rwx`): Full access — read, write, enter the directory ✅
> - Group (`5` = `r-x`): Can read and enter, but **cannot create or delete files** ✅
> - Others (`0` = `---`): **Zero access** — completely blocked ✅
>
> This means only `webuser` (owner) and members of the `webuser` group can access the directory. Everyone else is locked out.

## Fix the config file permissions

```bash
chmod 640 /opt/myapp/config.txt
```{{exec}}

> **`640` breakdown:**
> - Owner (`6` = `rw-`): Can read and write the config ✅
> - Group (`4` = `r--`): Can read but **cannot modify** ✅
> - Others (`0` = `---`): **Zero access** ✅
>
> Sensitive config files should almost always be `640` or `600`.

## Restore correct ownership

```bash
chown -R webuser:webuser /opt/myapp
```{{exec}}

> **`chown -R user:group path`:**
> - `-R` — apply **recursively** to all files and subdirectories inside `/opt/myapp`
> - `webuser:webuser` — set both the owner and the group to `webuser`

## Verify the corrected permissions

```bash
ls -la /opt/myapp/
```{{exec}}

You should now see:
- `drwxr-x---` for the directory (750)
- `-rw-r-----` for config.txt (640)

## Prove the fix works — try to access as attacker

```bash
su - attacker -c "cat /opt/myapp/config.txt"
```{{exec}}

> This runs `cat /opt/myapp/config.txt` as the `attacker` user in a single command. You should get:
> ```
> cat: /opt/myapp/config.txt: Permission denied
> ```
> That is **exactly what we want**. ✅

## Try to enter the directory as attacker

```bash
su - attacker -c "ls /opt/myapp/"
```{{exec}}

> Also `Permission denied` — the attacker cannot even see inside the directory.

---

> 🏆 **You have completed the security fix.** The same files that were fully exposed under `chmod 777` are now completely inaccessible to unauthorized users.

✅ Click **Continue** to see your lab summary.
