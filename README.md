# SystemSaver

**SystemSaver** is a zero-interaction system recovery script designed to safely back up a Linux user's home directory from a damaged or unbootable system via a live environment. It automatically detects root and USB partitions, mounts them, securely transfers user data using `rsync`, and optionally starts a local HTTP server for remote file retrieval.

---

## 🔥 Why SystemSaver?
This tool was born from real frustration. After experiencing a full system lockout due to a kernel panic, I spent an entire day manually recovering files inside a RAM-limited live environment. The lack of automated, intelligent tools in such critical moments inspired the creation of **SystemSaver**.

---

## ✨ Features

- Automatic root partition detection (ext4, btrfs)
- Auto-mount of user home directory and USB target device
- Safe and resumable backups using `rsync`
- Colored output with live status
- Optional HTTP server for LAN-based recovery
- Minimal dependencies (`bash`, `rsync`, `python3`, `mount`, `lsblk`)

---

## 🚀 Usage

### 1. Boot from a Linux Live USB (Pop!_OS, Ubuntu, etc.)
### 2. Connect a second USB drive for recovery
### 3. Run the script:

```bash
curl -O https://raw.githubusercontent.com/abkarada/SystemSaver/main/SystemSaver.sh
chmod +x SystemSaver.sh
./SystemSaver.sh
```

---

## 📂 Output

- Your backed-up home directory will be located inside the target USB (e.g., `/mnt/usb/your_username/`)
- If the HTTP server is started, files will be available at `http://<your-ip>:8080`

---

## ⚠️ Warning
- This script assumes a basic ext4/btrfs Linux root structure
- Do not use on mounted/active systems. Designed for **Live USB recovery only**
- All operations are non-destructive but still use caution

---

## 👨‍💻 Author
**Abdurrahman Karadağ**  
Created with real battle scars during system failure. 

