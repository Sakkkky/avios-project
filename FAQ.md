# AVIOS - Frequently Asked Questions

## General Questions

### What is AVIOS?
AVIOS (Advanced Virtualized Intelligence Operating System) is a custom Linux-based operating system designed for cybersecurity professionals, penetration testers, and ethical hackers. It combines a modern, hacker-themed user interface with comprehensive security testing tools similar to Kali Linux.

### Is AVIOS free?
Yes, AVIOS is completely free and open-source, released under the MIT License.

### What makes AVIOS different from Kali Linux?
While AVIOS includes similar security tools to Kali Linux, it features:
- Custom modern UI with cyber/hacker aesthetics
- Lightweight and optimized for virtual machines
- Simplified tool launcher interface
- Built specifically for QEMU emulation on Windows

### Can I use AVIOS for production security testing?
AVIOS is designed for educational purposes and authorized security testing. Always ensure you have explicit permission before testing any systems.

## Installation & Setup

### Do I need to install Linux to use AVIOS?
No! AVIOS runs in QEMU on Windows 11 without requiring a Linux installation or dual-boot setup.

### What are the system requirements?
**Minimum:**
- Windows 11 (64-bit)
- 4GB RAM
- 20GB free disk space
- CPU with virtualization support

**Recommended:**
- 8GB+ RAM
- SSD storage
- 4+ CPU cores
- Virtualization enabled in BIOS

### How do I enable virtualization in BIOS?
1. Restart your computer
2. Enter BIOS (usually F2, F10, Del, or Esc during boot)
3. Find "Virtualization Technology", "Intel VT-x", or "AMD-V"
4. Enable it
5. Save and exit

### Where do I download QEMU?
Download from the official QEMU website: https://qemu.weilnetz.de/w64/

### How long does it take to build AVIOS?
The full build process (using `build-system.sh`) takes 30-60 minutes depending on your system and internet speed.

## Usage Questions

### How do I start AVIOS on Windows 11?
1. Install QEMU
2. Get the `avios.iso` file
3. Run `run-avios.bat` or `run-avios.ps1`

See WINDOWS_SETUP_GUIDE.md for detailed instructions.

### Can I run AVIOS on macOS?
Yes, but you'll need to install QEMU for macOS. The setup process is similar to Windows.

### Can I run AVIOS on actual hardware?
Yes, you can boot from the ISO on physical hardware, but it's primarily designed for virtual machine use.

### How do I access the terminal?
The terminal opens automatically on startup. You can also click the terminal icon in the dock or use Ctrl+Alt+T.

### What is the default username and password?
**Username:** root  
**Password:** (no password by default for live system)

For security, it's recommended to set a password after booting.

## Tools & Features

### What security tools are included?
AVIOS includes tools for:
- Network scanning (Nmap, Masscan)
- Web application testing (SQLMap, Nikto, Burp Suite)
- Password cracking (John, Hashcat, Hydra)
- Wireless security (Aircrack-ng)
- Exploitation (Metasploit Framework)
- Forensics (Binwalk, Volatility)
- And many more...

See TOOLS_REFERENCE.md for complete list and usage.

### How do I install additional tools?
Connect to the internet and use apt:
```bash
apt-get update
apt-get install <tool-name>
```

### Can I use the tools on real networks?
**Only with explicit authorization!** Unauthorized network scanning or penetration testing is illegal. Always get written permission.

### Do the tools work in the VM?
Yes, most tools work normally. Some hardware-specific tools (like WiFi monitoring) may require USB passthrough or may not work in a VM.

## Troubleshooting

### QEMU won't start / Black screen
**Solutions:**
- Enable virtualization in BIOS
- Try different graphics: `-vga std` instead of `-vga virtio`
- Update graphics drivers
- Allocate more RAM: `-m 4096`

### Mouse doesn't work properly
**Solutions:**
- Add `-device usb-tablet` to QEMU command (already in default scripts)
- Press Ctrl+Alt+G to release/capture mouse
- Try `-usb -device usb-mouse`

### Keyboard layout is wrong
Boot AVIOS and run:
```bash
loadkeys <your-layout>  # e.g., loadkeys us, loadkeys uk
```

To make permanent, edit `/etc/default/keyboard`.

### Network doesn't work in VM
**Solutions:**
- Check Windows Firewall
- Try different network mode: `-net nic,model=e1000 -net user`
- Enable internet sharing in Windows
- Use bridge networking (advanced)

### Performance is very slow
**Solutions:**
- Enable hardware acceleration: `-accel whpx`
- Allocate more RAM: `-m 4096`
- Use more CPU cores: `-smp 4`
- Use VirtIO drivers: `-vga virtio`
- Close other applications
- Ensure virtualization is enabled in BIOS

### UI doesn't load / Firefox doesn't start
**Solutions:**
- Wait 1-2 minutes for system to fully boot
- Check logs: `journalctl -xe`
- Manually start: `start-avios`
- Restart the VM

### Tools crash or don't work
**Solutions:**
- Update tool: `apt-get update && apt-get upgrade`
- Check tool documentation: `<tool> --help`
- Allocate more RAM to VM
- Some tools may need root: `sudo <command>`

## Advanced Usage

### How do I save my work?
Create a virtual hard disk:
```bash
qemu-img create -f qcow2 avios-storage.qcow2 20G
```

Then add to QEMU command:
```bash
-drive file=avios-storage.qcow2,format=qcow2
```

Mount and use the disk in AVIOS.

### Can I install AVIOS permanently to a virtual disk?
Yes! Boot with both ISO and virtual disk, then install the system to the disk. After installation, boot from the disk only.

### How do I share files between Windows and AVIOS?
**Options:**
1. **Shared folder** (requires QEMU guest additions)
2. **Network share** (SMB/SAMBA)
3. **HTTP server** (simple file transfer)
4. **SCP/SFTP** if SSH is enabled

Example HTTP server in Windows:
```powershell
# In your shared folder
python -m http.server 8000
```

Then in AVIOS:
```bash
wget http://10.0.2.2:8000/file.txt
```

### How do I enable SSH access?
In AVIOS:
```bash
systemctl start ssh
systemctl enable ssh
```

Then connect from Windows:
```bash
ssh -p 2222 root@localhost
```

(Requires port forwarding: `-net user,hostfwd=tcp::2222-:22`)

### Can I run multiple AVIOS instances?
Yes, just launch QEMU multiple times with different configurations. Make sure to use different ports if forwarding.

### How do I update AVIOS?
```bash
apt-get update
apt-get upgrade
apt-get dist-upgrade
```

Or rebuild from source with latest code.

## Legal & Ethical

### Is it legal to use AVIOS?
Yes, AVIOS itself is legal. However, using the security tools without authorization on systems you don't own is illegal in most jurisdictions.

### What can I legally test?
You can legally test:
- Your own systems and networks
- Systems where you have explicit written authorization
- Lab environments set up for practice
- Bug bounty programs (follow their rules)
- CTF (Capture The Flag) competitions

### What is illegal?
Illegal activities include:
- Scanning or testing networks without permission
- Accessing systems without authorization
- Intercepting communications without consent
- Distributing malware
- DDoS attacks

### How do I get authorization for security testing?
1. Get written permission from system owner
2. Define scope clearly (what can/cannot be tested)
3. Set time limits
4. Agree on testing methods
5. Define reporting procedures
6. Both parties sign agreement

### Resources for learning ethically
- TryHackMe: https://tryhackme.com/
- HackTheBox: https://www.hackthebox.eu/
- OWASP WebGoat: https://owasp.org/www-project-webgoat/
- PentesterLab: https://pentesterlab.com/
- VulnHub: https://www.vulnhub.com/

## Support & Community

### Where can I get help?
1. Read this FAQ
2. Check WINDOWS_SETUP_GUIDE.md
3. Review TOOLS_REFERENCE.md
4. Search existing issues on GitHub
5. Ask in community forums

### How do I report bugs?
Please open an issue on GitHub with:
- Detailed description
- Steps to reproduce
- System information
- Error messages/logs
- Screenshots if relevant

### Can I contribute to AVIOS?
Yes! Contributions are welcome:
- Bug fixes
- New features
- Documentation improvements
- Tool integrations
- UI enhancements

Fork the repository and submit pull requests.

### Where is the source code?
[GitHub repository link would go here]

## Miscellaneous

### Why is it called AVIOS?
AVIOS stands for "Advanced Virtualized Intelligence Operating System" - emphasizing its VM-focused design and intelligent tool integration.

### Who created AVIOS?
AVIOS is a community project for cybersecurity education and ethical hacking practice.

### Is AVIOS based on Kali Linux?
No, AVIOS is built from Ubuntu but includes similar security tools to Kali Linux.

### Can I customize the UI?
Yes! The UI files are in `/opt/avios/`. You can modify the HTML, CSS, and JavaScript to customize appearance and functionality.

### Does AVIOS collect any data?
No, AVIOS does not collect, transmit, or store any user data. It's completely offline and privacy-focused.

### Can I use AVIOS for certifications?
AVIOS can be used for practice, but check specific certification requirements. Some certifications require Kali Linux specifically.

### What's next for AVIOS?
Planned features:
- More tool integrations
- Persistence layer improvements
- Enhanced UI features
- Better hardware support
- Container support
- Cloud integration options

---

## Still have questions?

If your question isn't answered here:
1. Check the documentation in the `docs/` folder
2. Search GitHub issues
3. Join the community discussions
4. Open a new issue with your question

**Remember: Use AVIOS responsibly and ethically!**
