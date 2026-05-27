# 🎯 AVIOS Setup - SIMPLE STEP-BY-STEP GUIDE

## Your Directory: `D:\personal_projects\avios-project`

---

## ✅ OPTION 1: Test Beautiful UI (30 Seconds) - NO SETUP NEEDED!

### Step 1: Open File Explorer
- Press `Windows Key + E`
- Go to: `D:\personal_projects\avios-project`

### Step 2: Open the UI
- Find folder: `ui`
- Double-click: `desktop.html`
- It opens in your browser!

**That's it! You'll see the beautiful AVIOS interface immediately. No installation required!**

---

## ⚙️ OPTION 2: Run Full AVIOS with QEMU (5 Minutes Setup)

### Prerequisites Check
Before you start, you need:
- [ ] Windows 11
- [ ] At least 4GB RAM free
- [ ] 10GB disk space
- [ ] Internet connection

### Step 1: Install Python 3 (If Not Installed)

**Check if Python is installed:**
1. Press `Windows Key + R`
2. Type: `python --version`
3. Press Enter

**If it says "not recognized":**
1. Go to: https://www.python.org/downloads/
2. Click: "Download Python 3.x.x"
3. Run the installer
4. **IMPORTANT:** Check the box: ✓ "Add Python to PATH"
5. Click: "Install Now"
6. Wait for completion
7. Click: "Close"

### Step 2: Install QEMU (The Emulator)

1. Go to: https://qemu.weilnetz.de/w64/
2. Download: `qemu-w64-setup-xxxxx.exe` (latest version)
3. Run the installer
4. Click "Next" > "Next" > "Install" > "Finish"

### Step 3: Add QEMU to PATH (Important!)

1. Press: `Windows Key + X`
2. Click: "System"
3. Click: "Advanced system settings" (left side)
4. Click: "Environment Variables" (bottom right)
5. Under "System variables", find: "Path"
6. Click: "Edit"
7. Click: "New"
8. Type: `C:\Program Files\qemu`
9. Click "OK" > "OK" > "OK"
10. **Restart your computer**

### Step 4: Run AVIOS

1. Go to: `D:\personal_projects\avios-project`
2. Double-click: `SETUP_WIZARD.bat`
3. Choose option: `2` (Setup QEMU and run full AVIOS)
4. AVIOS will start!

---

## 🚀 QUICK TEST (No Installation)

Just want to see if it works first?

### Test 1: See the UI
```
1. Go to: D:\personal_projects\avios-project\ui
2. Double-click: desktop.html
3. Browser opens with beautiful interface!
```

### Test 2: Use Setup Wizard
```
1. Go to: D:\personal_projects\avios-project
2. Double-click: SETUP_WIZARD.bat
3. Choose: Option 1 (Test UI)
```

---

## 📊 What You Need for Each Option

| Option | Need Python? | Need QEMU? | Time | What You Get |
|--------|---|---|---|---|
| **UI Test** | No | No | 10 sec | Beautiful interface |
| **Full OS** | Yes | Yes | 5 min | Complete working OS |
| **Build Custom** | Yes | Yes | 60 min | Custom OS (advanced) |

---

## 🔍 Troubleshooting

### "Python not found" Error
- [ ] Did you install Python?
- [ ] Did you check "Add to PATH"?
- [ ] Did you restart after installation?
- [ ] Try: Download installer again, uninstall old Python, reinstall with PATH checked

### "QEMU not found" Error
- [ ] Install QEMU first
- [ ] Add QEMU to PATH
- [ ] Restart computer
- [ ] Try running again

### "File not found" Error
- [ ] Make sure you're in the right directory: `D:\personal_projects\avios-project`
- [ ] Check if all files are extracted properly
- [ ] Re-extract if needed

### "Black screen" when running
- [ ] Normal - it's booting
- [ ] Wait 30 seconds
- [ ] If nothing happens, check troubleshooting guide

---

## 📱 SETUP WIZARD (Easiest Method)

The easiest way is to use the wizard:

```
1. Go to: D:\personal_projects\avios-project
2. Double-click: SETUP_WIZARD.bat
3. Follow the menu
4. Wizard does everything for you!
```

**The wizard will:**
- ✓ Check if Python is installed
- ✓ Check if QEMU is installed
- ✓ Download links if needed
- ✓ Test the UI
- ✓ Run AVIOS
- ✓ Help with troubleshooting

---

## 🎓 Learning Path

### Day 1 (30 minutes)
- [ ] Test the UI (see how it looks)
- [ ] Read: `START_HERE.md`
- [ ] Read: `QUICK_START.md`

### Day 2 (1 hour)
- [ ] Install Python
- [ ] Install QEMU
- [ ] Run full AVIOS

### Day 3 (2 hours)
- [ ] Explore the tools
- [ ] Read: `tools/TOOLS_REFERENCE.md`
- [ ] Practice commands

### Ongoing
- [ ] Use TryHackMe (https://tryhackme.com/)
- [ ] Practice on HackTheBox (https://www.hackthebox.eu/)
- [ ] Build your skills

---

## 💡 Important Notes

### Legal & Ethical
- ✅ Practice on test systems only
- ✅ Get written permission before testing
- ✅ Follow laws in your country
- ✅ Use for learning only

### System Requirements
- Windows 11 (or Windows 10)
- 4GB+ RAM
- 10GB disk space
- Virtualization enabled (usually default)

### Performance Tips
- Close other programs before running QEMU
- More RAM = faster (allocate 4GB minimum)
- SSD is faster than HDD
- Enable virtualization in BIOS (if available)

---

## 🆘 Need Help?

### Quick Help
1. Check: `FAQ.md` (50+ questions answered)
2. Read: `WINDOWS_SETUP_GUIDE.md` (detailed guide)
3. Review: `QUICK_START.md` (common issues)

### Still Stuck?
- Read the error message carefully
- Check troubleshooting section above
- Look up the error online
- All documentation is included

---

## 🎉 What Comes Next?

Once AVIOS is running:

1. **Explore the Interface**
   - Click around
   - Try the terminal
   - See the tool launcher

2. **Learn the Tools**
   - Read tool documentation
   - Try commands in terminal
   - Practice safely

3. **Practice**
   - Use TryHackMe
   - Use HackTheBox
   - Build your skills

4. **Customize**
   - Modify the UI (edit CSS)
   - Add more tools
   - Build your custom OS

---

## 📋 Checklist

Before you start:
- [ ] Windows 11 or 10 installed
- [ ] 4GB+ RAM available
- [ ] 10GB free disk space
- [ ] All AVIOS files in `D:\personal_projects\avios-project`
- [ ] Internet connection
- [ ] Text editor (Notepad is fine)

Ready to install:
- [ ] Python 3 (from python.org)
- [ ] QEMU (from qemu.weilnetz.de)
- [ ] Both added to PATH
- [ ] Computer restarted

---

## 🚀 QUICK START COMMAND

Just copy and paste these commands in Command Prompt (open with Ctrl+R, type `cmd`):

```cmd
REM Go to your project folder
cd /d D:\personal_projects\avios-project

REM Test the UI
test-ui.bat

REM Or use the setup wizard
SETUP_WIZARD.bat
```

---

## 🎊 You're Ready!

**Next Step:**
1. Go to: `D:\personal_projects\avios-project`
2. Double-click: `SETUP_WIZARD.bat`
3. Follow the menu

**Happy ethical hacking! 🔐**

---

## 📞 Support

All documentation is included:
- START_HERE.md
- QUICK_START.md
- WINDOWS_SETUP_GUIDE.md
- FAQ.md
- TOOLS_REFERENCE.md

Everything you need is already there! Just follow the steps. Good luck! 🌟
