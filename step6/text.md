# Step 6 — Demonstrate the Access Risk 🔓

Now we prove the danger. We'll switch to the `attacker` account — a user with **no special privileges** — and show exactly what they can do because of the `chmod 777` misconfiguration.

## Switch to the attacker account

```bash
su - attacker
```{{exec}}

> **`su - username`** — "switch user". The `-` loads a complete login shell for that user, including their environment variables. You are now acting as `attacker`.

Confirm who you are:

```bash
whoami && id
```{{exec}}

## Attack 1 — READ the sensitive config (Data Leak)

```bash
cat /opt/myapp/config.txt
```{{exec}}

> 😱 **The attacker can now see `DB_PASSWORD`, `API_KEY`, and `DB_HOST` in plain text.** This is a full credential leak. In a real system, this could mean database access, API abuse, or total account takeover.

## Attack 2 — MODIFY the config (Tampering)

```bash
echo "BACKDOOR=attacker_was_here" >> /opt/myapp/config.txt
cat /opt/myapp/config.txt
```{{exec}}

> 😱 **The attacker injected a backdoor entry into the config file.** When the application reads this file next, it will process attacker-controlled data. This is how credential stuffing and supply-chain attacks begin.

## Attack 3 — DELETE the config (Destruction / DoS)

```bash
rm /opt/myapp/config.txt
ls /opt/myapp/
```{{exec}}

> 😱 **The config file is gone.** The application will crash on next startup because its config is missing. This is a Denial of Service attack from within the system itself.

## Switch back to root

```bash
exit
```{{exec}}

```bash
whoami
```{{exec}}

---

> **The lesson:** A single `chmod 777` turned a secure application into one that any user on the system can read, tamper with, and destroy. This is why permissions matter.

✅ Click **Continue** to fix the problem properly.
