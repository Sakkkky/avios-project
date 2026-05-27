# AVIOS on Windows 11 - Complete Setup Guide

## Prerequisites

### System Requirements
- Windows 11 (64-bit)
- 4GB RAM minimum (8GB recommended)
- 20GB free disk space
- CPU with virtualization support (Intel VT-x or AMD-V)

### Enable Virtualization in BIOS
1. Restart your computer
2. Enter BIOS/UEFI (usually F2, F10, or Delete during boot)
3. Find "Virtualization Technology" or "Intel VT-x" or "AMD-V"
4. Enable it
5. Save and exit

## Step 1: Install QEMU

### Download QEMU
1. Visit: https://qemu.weilnetz.de/w64/
2. Download the latest Windows installer (e.g., `qemu-w64-setup-20230424.exe`)
3. Run the installer
4. Install to default location: `C:\Program Files\qemu`

### Add QEMU to PATH
1. Press `Win + X` and select "System"
2. Click "Advanced system settings"
3. Click "Environment Variables"
4. Under "System variables", find "Path" and click "Edit"
5. Click "New" and add: `C:\Program Files\qemu`
6. Click OK on all dialogs

### Verify Installation
Open Command Prompt or PowerShell:
```cmd
qemu-system-x86_64.exe --version
```

You should see QEMU version information.

## Step 2: Get AVIOS ISO

### Option A: Download Pre-built ISO
If you have a pre-built `avios.iso`, place it in a convenient location like:
```
C:\Users\YourName\AVIOS\avios.iso
```

### Option B: Build from Source (Advanced)
Requires Linux or WSL2:
1. Install WSL2: `wsl --install`
2. Clone AVIOS repository
3. Run build script: `sudo ./scripts/build-system.sh`
4. Copy generated ISO to Windows

## Step 3: Running AVIOS

### Method 1: Using the Batch Script (Easiest)

1. Place `run-avios.bat` in the same folder as `avios.iso`
2. Double-click `run-avios.bat`
3. AVIOS will start in QEMU

### Method 2: Manual Command Line

Open Command Prompt or PowerShell in the folder containing `avios.iso`:

```cmd
qemu-system-x86_64.exe -m 2048 -smp 2 -cdrom avios.iso -boot d -vga virtio -display sdl,gl=on -usb -device usb-tablet -net nic,model=virtio -net user -name "AVIOS"
```

### Method 3: PowerShell Script (Recommended)

Save as `run-avios.ps1`:

```powershell
# AVIOS Launcher PowerShell Script
$qemu = "qemu-system-x86_64.exe"
$iso = "avios.iso"

if (!(Test-Path $iso)) {
    Write-Host "ERROR: avios.iso not found!" -ForegroundColor Red
    exit 1
}

Write-Host "Starting AVIOS..." -ForegroundColor Green
Write-Host "RAM: 2GB | CPU: 2 cores | Display: VirtIO" -ForegroundColor Cyan

& $qemu `
    -m 2048 `
    -smp 2 `
    -cdrom $iso `
    -boot d `
    -vga virtio `
    -display sdl,gl=on `
    -usb `
    -device usb-tablet `
    -net nic,model=virtio `
    -net user `
    -name "AVIOS"
```

Run with: `powershell -ExecutionPolicy Bypass -File run-avios.ps1`

## Step 4: QEMU Configuration Options

### Performance Options

#### Increase RAM
```cmd
-m 4096          # 4GB RAM
-m 8192          # 8GB RAM
```

#### More CPU Cores
```cmd
-smp 4           # 4 CPU cores
-smp cores=4,threads=2  # 4 cores, 2 threads each
```

#### Enable KVM (if available)
```cmd
-accel whpx      # Windows Hypervisor Platform
```

### Display Options

#### Different Graphics Adapters
```cmd
-vga std         # Standard VGA
-vga virtio      # VirtIO (recommended)
-vga qxl         # QXL (for SPICE)
```

#### Fullscreen
```cmd
-display sdl,gl=on -full-screen
```

### Storage Options

#### Create Virtual Hard Disk
```cmd
# Create 20GB virtual disk
qemu-img create -f qcow2 avios-disk.qcow2 20G

# Use the disk
-drive file=avios-disk.qcow2,format=qcow2
```

#### Boot from disk instead of CD
```cmd
-boot c          # Boot from hard disk
```

### Network Options

#### Port Forwarding (SSH example)
```cmd
-net user,hostfwd=tcp::2222-:22
```
Then connect: `ssh -p 2222 root@localhost`

#### Bridge Networking
```cmd
-net nic -net bridge,br=br0
```

### Complete Example Configuration
```cmd
qemu-system-x86_64.exe ^
    -name "AVIOS Production" ^
    -m 4096 ^
    -smp 4 ^
    -cdrom avios.iso ^
    -drive file=avios-disk.qcow2,format=qcow2 ^
    -boot order=dc ^
    -vga virtio ^
    -display sdl,gl=on ^
    -usb ^
    -device usb-tablet ^
    -net nic,model=virtio ^
    -net user,hostfwd=tcp::2222-:22,hostfwd=tcp::8080-:8080 ^
    -rtc base=localtime ^
    -cpu host ^
    -accel whpx
```

## Keyboard Shortcuts in QEMU

- **Ctrl + Alt + G**: Release mouse cursor
- **Ctrl + Alt + F**: Toggle fullscreen
- **Ctrl + Alt + 1**: Switch to VM display
- **Ctrl + Alt + 2**: Switch to QEMU monitor
- **Ctrl + Alt + 3**: Switch to serial console

## Troubleshooting

### Error: QEMU not found
- Ensure QEMU is installed
- Verify PATH environment variable
- Try using full path: `"C:\Program Files\qemu\qemu-system-x86_64.exe"`

### Error: Could not access KVM kernel module
- This is normal on Windows (KVM is Linux-only)
- Remove `-enable-kvm` from command
- Use `-accel whpx` instead (requires Hyper-V)

### Slow Performance
- Enable hardware acceleration: `-accel whpx`
- Increase RAM: `-m 4096`
- Add more CPU cores: `-smp 4`
- Use VirtIO drivers: `-vga virtio`

### Black Screen
- Try different graphics adapter: `-vga std`
- Disable OpenGL: `-display sdl`
- Check BIOS virtualization settings

### Network Not Working
- Check firewall settings
- Try different network mode:
  ```cmd
  -net nic,model=e1000 -net user
  ```

### Mouse Not Working Properly
- Add tablet device: `-device usb-tablet`
- Press Ctrl + Alt + G to release/capture

## Enable Hyper-V Platform (Optional)

For better performance with `-accel whpx`:

### Via PowerShell (Admin)
```powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All
```

### Via Windows Features
1. Press `Win + R`, type `optionalfeatures`
2. Enable "Hyper-V" and "Windows Hypervisor Platform"
3. Restart computer

## Creating Desktop Shortcut

1. Right-click on Desktop → New → Shortcut
2. Location: 
   ```
   "C:\Program Files\qemu\qemu-system-x86_64.exe" -m 2048 -smp 2 -cdrom "C:\Users\YourName\AVIOS\avios.iso" -boot d -vga virtio
   ```
3. Name: "AVIOS"
4. Change icon (optional)

## Tips for Best Experience

1. **Use SSD**: Store ISO and virtual disks on SSD for better performance
2. **Close Background Apps**: Free up RAM and CPU for better VM performance
3. **Disable Antivirus Temporarily**: Some AV software may slow down QEMU
4. **Use Wired Network**: Better performance than WiFi for VM networking
5. **Regular Snapshots**: Use QEMU snapshots to save VM states

## Next Steps

Once AVIOS is running:
1. Explore the security tools in the launcher panel
2. Open terminal and run `neofetch` to see system info
3. Test network tools: `nmap localhost`
4. Read the tools reference: `/opt/avios/TOOLS_REFERENCE.md`

## Support

For issues or questions:
- Check the main README.md
- Review QEMU documentation: https://www.qemu.org/docs/master/
- AVIOS GitHub Issues (if applicable)

## Advanced: Persistent Installation

To install AVIOS to a virtual hard disk:

1. Create virtual disk:
   ```cmd
   qemu-img create -f qcow2 avios-hdd.qcow2 40G
   ```

2. Boot with both ISO and disk:
   ```cmd
   qemu-system-x86_64.exe -m 4096 -smp 4 -cdrom avios.iso -drive file=avios-hdd.qcow2,format=qcow2 -boot order=dc
   ```

3. Install AVIOS to the virtual disk (if installer provided)

4. After installation, boot from disk only:
   ```cmd
   qemu-system-x86_64.exe -m 4096 -smp 4 -drive file=avios-hdd.qcow2,format=qcow2 -boot c
   ```
