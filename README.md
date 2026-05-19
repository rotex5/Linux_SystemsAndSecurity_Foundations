# System Control & Security Lab — KillerCoda Scenario

A hands-on interactive lab covering web server deployment, process monitoring, user management, and Linux file permission security.

## Scenario Structure

```
killercoda-scenario/
├── index.json          ← Scenario config (title, steps, backend image)
├── background.sh       ← Runs silently on load to set up the environment
├── intro.md            ← Welcome screen shown before Step 1
├── finish.md           ← Completion summary shown after Step 7
├── step1/
│   ├── text.md         ← Instructions shown to the learner
│   └── verify.sh       ← Auto-check script that runs when they click Continue
├── step2/ ...
├── step3/ ...
├── step4/ ...
├── step5/ ...
├── step6/ ...
└── step7/
    ├── text.md
    └── verify.sh
```

## How to Publish on KillerCoda

1. **Create a GitHub account** (if you don't have one) at https://github.com
2. **Create a new public repository** — e.g. `my-security-lab`
3. **Push this entire folder** to the repository:
   ```bash
   git init
   git add .
   git commit -m "Add system control and security lab"
   git remote add origin https://github.com/YOUR_USERNAME/my-security-lab.git
   git push -u origin main
   ```
4. **Go to https://killercoda.com** and sign up / log in
5. In your KillerCoda profile settings, **link your GitHub repository**
6. KillerCoda will automatically sync and publish the scenario — usually within 1 minute
7. Share your scenario URL: `https://killercoda.com/YOUR_USERNAME/scenario/killercoda-scenario`

## Lab Overview

| Step | Topic | Verify Check |
|------|-------|-------------|
| 1 | Run a Python web server | `pgrep http.server` |
| 2 | Analyze PID and resource usage | `ss -tlnp` port 8080 active |
| 3 | Kill and restart the process | Server running again |
| 4 | Create user and app directory | Users and config file exist |
| 5 | Misconfigure to chmod 777 | `stat` confirms 777 |
| 6 | Demonstrate access risk | Back to root after attack |
| 7 | Apply least privilege (750/640) | Attacker gets Permission denied |

## Customising the Scenario

- Edit any `stepN/text.md` to change instructions or add hints
- Edit `stepN/verify.sh` to change what counts as completion
- Edit `index.json` to rename steps or change the Ubuntu image
- The `background.sh` runs silently at start — add any pre-setup commands there
Linux_SystemsAndSecurity_Foundations
