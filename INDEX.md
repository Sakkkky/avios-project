# AVIOS Project - Complete Index

## 📍 Start Here
- **START_HERE.md** ← Begin with this file!
- **QUICK_START.md** - Fast 5-minute setup
- **README.md** - Full project overview

## 🎯 For First-Time Users

### Windows 11 Users
1. Read: `WINDOWS_SETUP_GUIDE.md`
2. Install: QEMU (https://qemu.weilnetz.de/w64/)
3. Run: `run-avios.bat` or `test-ui.bat`

### Linux/Mac Users
1. Read: `QUICK_START.md`
2. Run: `./scripts/test-ui.sh` to test UI
3. Run: `sudo ./scripts/build-system.sh` for full build

## 📚 Documentation Map

### Getting Started
```
START_HERE.md           ← Read this first!
QUICK_START.md          ← 5-minute guide
README.md               ← Project overview
WINDOWS_SETUP_GUIDE.md  ← Windows detailed guide
FAQ.md                  ← Common questions
```

### Technical Reference
```
PROJECT_STRUCTURE.md    ← File organization
tools/TOOLS_REFERENCE.md ← How to use all tools
CHANGELOG.md            ← What's included
LICENSE                 ← Legal info
```

## 🎨 User Interface

### Files
```
ui/desktop.html    ← Main interface (start here!)
ui/style.css       ← Modern hacker theme
ui/desktop.js      ← Features & terminal
```

### How to Access
- **Direct:** Open `ui/desktop.html` in browser
- **Server:** Run `test-ui.bat` (Windows) or `./scripts/test-ui.sh` (Linux)
- **In OS:** Runs automatically on AVIOS boot

## 🔧 Building & Configuration

### Scripts
```
scripts/build-system.sh      ← Full OS build (30-60 min)
scripts/quick-build.sh       ← Demo ISO (5 min)
scripts/test-ui.sh           ← UI test server
scripts/verify-install.sh    ← Check setup
```

### Configuration
```
kernel/avios-kernel.config   ← Linux kernel
bootloader/grub.cfg          ← Boot configuration
tools/install-tools.sh       ← Security tools
```

## 🎮 Launchers

### Windows
```
run-avios.bat       ← Simple launcher
run-avios.ps1       ← Advanced launcher with options
test-ui.bat         ← Test UI directly
```

### Linux/Mac
```
./scripts/test-ui.sh        ← Test UI
./scripts/build-system.sh   ← Build full OS
```

## 🛠️ Security Tools (50+)

### Categories
- Network Analysis (Nmap, Wireshark, etc.)
- Web Testing (SQLMap, Nikto, Burp, etc.)
- Password Cracking (John, Hashcat, Hydra)
- Wireless (Aircrack-ng suite)
- Exploitation (Metasploit)
- Forensics (Binwalk, Volatility)
- Reverse Engineering (Radare2, GDB)
- Information Gathering (theHarvester, Whois)

**Full reference:** `tools/TOOLS_REFERENCE.md`

## 📊 Quick Facts

| Question | Answer |
|----------|--------|
| What is AVIOS? | Custom Linux OS with hacker-themed UI |
| Can I use on Windows 11? | Yes, via QEMU (emulator) |
| Do I need to install Linux? | No, runs in VM |
| How long to set up? | 5 minutes (UI) or 2 hours (full) |
| Is it free? | Yes, MIT License |
| Can I customize it? | Yes, all source included |
| Legal to use? | Yes, for authorized testing only |
| What tools included? | 50+ security tools |

## 🚀 Quick Commands

### Test UI Now (30 seconds)
```cmd
test-ui.bat
```
Then open: `http://localhost:8080/desktop.html`

### Run Full OS (after QEMU install)
```cmd
run-avios.bat
```

### Build Custom OS (Linux/WSL, 30-60 min)
```bash
sudo ./scripts/build-system.sh
```

## ❓ Need Help?

1. **Can't get started?**
   - Read: `QUICK_START.md`

2. **Windows specific issues?**
   - Read: `WINDOWS_SETUP_GUIDE.md`

3. **How to use tools?**
   - Read: `tools/TOOLS_REFERENCE.md`

4. **Common questions?**
   - Read: `FAQ.md`

5. **Want to customize?**
   - Read: `PROJECT_STRUCTURE.md`

## 📁 File Organization

```
avios-project/
├── START_HERE.md           ← YOU ARE HERE (start first!)
├── INDEX.md                ← This file
├── README.md               ← Project overview
├── QUICK_START.md          ← 5-min guide
├── WINDOWS_SETUP_GUIDE.md  ← Windows detailed
├── FAQ.md                  ← Q&A
├── CHANGELOG.md            ← What's new
├── LICENSE                 ← Legal
├── PROJECT_STRUCTURE.md    ← File layout
│
├── ui/                     ← User interface
│   ├── desktop.html
│   ├── style.css
│   └── desktop.js
│
├── scripts/                ← Build tools
│   ├── build-system.sh
│   ├── quick-build.sh
│   ├── test-ui.sh
│   └── verify-install.sh
│
├── tools/                  ← Security tools
│   ├── install-tools.sh
│   └── TOOLS_REFERENCE.md
│
├── kernel/                 ← OS configuration
│   └── avios-kernel.config
│
├── bootloader/             ← Boot config
│   └── grub.cfg
│
└── [Generated during build]
    ├── avios.iso           ← Bootable OS
    └── iso-build/          ← Build files
```

## ✨ Features at a Glance

### UI Features
✨ Modern hacker theme  
🎨 Glowing neon effects  
🌙 Dark optimized theme  
⚡ Smooth animations  
💻 Terminal emulator  
📊 System monitor  
🕸️ Network visualizer  
🎮 Draggable windows  

### OS Features
🐧 Custom Linux OS  
🛡️ Security focused  
🚀 Fast boot  
📦 Lightweight  
🎯 Tool launcher  
🔧 Configurable  
🌐 Networking ready  
💾 Persistent storage support  

### Tool Features
🔧 50+ security tools  
📖 Well documented  
⚡ Pre-installed  
🎯 Quick launcher  
🖥️ Terminal access  
🔄 Updateable  
🎓 Learn-friendly  
✅ Tested & working  

## 🎓 Learning Path

1. **Beginner** - Test UI, explore interface
2. **Intermediate** - Run AVIOS, try basic tools
3. **Advanced** - Study tool reference, practice
4. **Expert** - Customize OS, build tools

See `QUICK_START.md` for detailed learning path.

## 🔐 Legal & Safety

### ✅ Legal Uses
- Educational learning
- Authorized testing
- Personal lab/VM
- CTF competitions
- Practice platforms

### ❌ Illegal Uses
- Unauthorized access
- Network testing without permission
- Production hacking
- Malware creation

**Always get written authorization!**

## 📞 Resources

### Documentation Files
- 10+ comprehensive guides
- Step-by-step instructions
- Troubleshooting help
- Tool references
- Examples included

### External Resources
- TryHackMe.com
- HackTheBox.eu
- OWASP.org
- OverTheWire.org

## 🎉 Ready to Start?

### Choose Your Path:

**Path 1: See the UI (5 min)**
```
→ Run test-ui.bat
→ Open browser
```

**Path 2: Run Full OS (2 min + QEMU)**
```
→ Install QEMU
→ Run run-avios.bat
```

**Path 3: Build Custom (1 hour)**
```
→ Read WINDOWS_SETUP_GUIDE.md
→ Run build-system.sh
```

---

**Next:** Open `START_HERE.md` to begin!

**Questions?** Check `FAQ.md` or `QUICK_START.md`

**Let's build! 🚀**
