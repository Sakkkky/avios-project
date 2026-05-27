# AVIOS Quick Start Guide

## 🚀 Fastest Way to Get Started (Windows 11)

### Option 1: Test the UI Immediately (No Installation Required)

1. **Open the UI folder** in this project
2. **Double-click** `test-ui.bat`
3. **Open browser** to `http://localhost:8080/desktop.html`
4. **Explore** the AVIOS interface!

This runs the UI locally without needing QEMU or building the full OS.

---

### Option 2: Run Full AVIOS in QEMU (Recommended)

#### Step 1: Install QEMU (One-time setup)
1. Download QEMU from: https://qemu.weilnetz.de/w64/
2. Run the installer
3. Add QEMU to your PATH

**Quick PATH Setup:**
- Press `Win + X` → System → Advanced system settings
- Environment Variables → System variables → Path → Edit
- New → Add: `C:\Program Files\qemu`
- OK all dialogs

#### Step 2: Build or Download AVIOS ISO
**Option A:** Download pre-built ISO (if available)
**Option B:** Build from source (requires Linux/WSL):
```bash
sudo ./scripts/build-system.sh
```

#### Step 3: Launch AVIOS
Double-click `run-avios.bat` or run:
```cmd
qemu-system-x86_64.exe -m 2048 -smp 2 -cdrom avios.iso -boot d -vga virtio
```

---

## 📋 What You Get

### Exceptional Hacker-Themed UI
- **Cyberpunk aesthetics** with neon accents
- **Dark theme** optimized for long sessions
- **Smooth animations** and modern design
- **Tool launcher** with quick access to all security tools
- **Live system monitor** showing CPU, RAM, network
- **Integrated terminal** with command history

### Kali Linux Tools Included
- **Network Scanning:** Nmap, Masscan, Wireshark
- **Web Testing:** SQLMap, Nikto, Burp Suite, Gobuster
- **Password Cracking:** John the Ripper, Hashcat, Hydra
- **Wireless:** Aircrack-ng suite
- **Exploitation:** Metasploit Framework
- **Forensics:** Binwalk, Volatility
- **And 50+ more tools**

---

## 🎮 Using AVIOS

### First Boot
1. AVIOS boots with animated loading screen
2. Desktop environment loads automatically
3. Terminal opens ready for commands
4. Explore tools in the launcher panel

### Keyboard Shortcuts (in QEMU)
- `Ctrl + Alt + G` - Release/capture mouse
- `Ctrl + Alt + F` - Toggle fullscreen
- `Ctrl + Alt + Q` - Quit QEMU

### Running Security Tools

#### Via GUI Launcher
Click any tool card in the left panel - it opens terminal with the tool ready

#### Via Terminal
```bash
# Network scanning
nmap -sV 192.168.1.1

# Web vulnerability scanning
nikto -h http://target.com

# Password cracking
john hashes.txt

# WiFi auditing
airmon-ng start wlan0

# And many more...
```

See `tools/TOOLS_REFERENCE.md` for complete tool documentation.

---

## 🔧 Configuration

### Allocate More Resources

Edit `run-avios.bat` or use PowerShell:

```powershell
# 4GB RAM, 4 CPU cores
.\run-avios.ps1 -Memory 4096 -CPUs 4

# Fullscreen mode
.\run-avios.ps1 -Fullscreen

# Enable hardware acceleration
.\run-avios.ps1 -EnableAccel
```

### Create Persistent Storage

```cmd
# Create 20GB virtual disk
qemu-img create -f qcow2 avios-data.qcow2 20G

# Add to launch command
-drive file=avios-data.qcow2,format=qcow2
```

### Port Forwarding (SSH Example)

```cmd
# Forward SSH (port 2222 on Windows → port 22 in AVIOS)
-net user,hostfwd=tcp::2222-:22

# Then connect from Windows:
ssh -p 2222 root@localhost
```

---

## 📚 Documentation

- **README.md** - Project overview
- **WINDOWS_SETUP_GUIDE.md** - Detailed Windows setup
- **tools/TOOLS_REFERENCE.md** - Complete tool documentation
- **FAQ.md** - Frequently asked questions
- **LICENSE** - Legal information

---

## 🐛 Troubleshooting

### QEMU Not Found
```
Error: 'qemu-system-x86_64.exe' is not recognized...
```
**Fix:** Install QEMU and add to PATH (see Step 1 above)

### Black Screen
**Fix:**
- Enable virtualization in BIOS
- Try `-vga std` instead of `-vga virtio`
- Allocate more RAM: `-m 4096`

### Slow Performance
**Fix:**
- Enable virtualization in BIOS
- Use hardware acceleration: `-accel whpx`
- Close background applications
- Allocate more resources

### Mouse Not Working
**Fix:**
- Press `Ctrl + Alt + G`
- Ensure `-device usb-tablet` is in command (it is by default)

### Network Issues
**Fix:**
- Check Windows Firewall
- Try different network adapter: `-net nic,model=e1000 -net user`

**Still stuck?** Check FAQ.md for more solutions.

---

## ⚖️ Legal & Ethical Use

### ✅ Legal Uses
- Testing your own systems
- Authorized penetration testing (with written permission)
- Security research and education
- CTF competitions and practice labs

### ❌ Illegal Uses
- Scanning networks without authorization
- Unauthorized access to systems
- Intercepting communications without consent
- Any activity without explicit permission

**Always get written authorization before security testing!**

### Learning Resources
- TryHackMe: https://tryhackme.com/
- HackTheBox: https://www.hackthebox.eu/
- OWASP WebGoat: https://owasp.org/www-project-webgoat/
- OverTheWire: https://overthewire.org/

---

## 🎯 Next Steps

1. **Explore the UI** - Click around, try different tools
2. **Read tool docs** - tools/TOOLS_REFERENCE.md
3. **Practice safely** - Use practice labs like TryHackMe
4. **Customize** - Modify the UI in `ui/` folder
5. **Learn more** - Take ethical hacking courses

---

## 💡 Tips for Best Experience

1. **Use SSD** - Store ISO on SSD for better performance
2. **Allocate Resources** - Give AVIOS enough RAM and CPU
3. **Learn the Tools** - Don't just run commands, understand them
4. **Stay Legal** - Only test authorized systems
5. **Keep Updated** - Run `apt-get update` regularly
6. **Take Snapshots** - Save VM states before major changes
7. **Practice Regularly** - Skills improve with consistent practice

---

## 🌟 Features to Explore

- **Network Visualizer** - See live network activity (bottom right)
- **System Monitor** - Real-time CPU/RAM/Network stats (top right)
- **Terminal** - Full bash shell with all standard tools
- **Tool Cards** - Click to launch tools with one click
- **Multi-window** - Run multiple tools simultaneously
- **Drag & Drop** - Rearrange windows
- **Dark Theme** - Easy on the eyes for long sessions

---

## 🚨 Important Reminders

- **Backup your work** - Use persistent storage or export files
- **VMs are not perfectly secure** - Don't use for highly sensitive work
- **Practice in safe environments** - Use lab VMs, not production systems
- **Learn continuously** - Cybersecurity evolves rapidly
- **Follow the law** - Respect privacy and computer fraud laws
- **Be ethical** - Use your skills to improve security, not break it

---

## 📞 Getting Help

1. Check **FAQ.md** first
2. Review documentation files
3. Search existing GitHub issues
4. Ask in community forums
5. Open new issue with details

---

**Ready to start?** Run `test-ui.bat` to see the interface, or `run-avios.bat` to launch the full OS!

**Happy (ethical) hacking! 🔐**
