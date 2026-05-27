# AVIOS Launcher - PowerShell Edition
# Advanced launcher with configuration options

param(
    [int]$Memory = 2048,
    [int]$CPUs = 2,
    [switch]$Fullscreen,
    [switch]$EnableAccel,
    [string]$IsoPath = "avios.iso"
)

# Colors
$ErrorColor = "Red"
$SuccessColor = "Green"
$InfoColor = "Cyan"
$WarningColor = "Yellow"

# ASCII Art Banner
$banner = @"
    ___  _    ______  _____ 
   / _ \| |  / /  _ \/ ____|
  / /_\ \ | / /| | | | (___ 
  |  _  | |/ / | | | |\___ \
  | | | |   /| |_| |_____) |
  \_| |_/_/\_\\___/|_____/ 
                            
  Advanced Virtualized Intelligence OS
  Running on QEMU Emulator
"@

Write-Host $banner -ForegroundColor $InfoColor
Write-Host ("=" * 50) -ForegroundColor $InfoColor
Write-Host ""

# Check for QEMU
Write-Host "[*] Checking for QEMU..." -ForegroundColor $InfoColor
$qemuPath = Get-Command qemu-system-x86_64.exe -ErrorAction SilentlyContinue

if (-not $qemuPath) {
    Write-Host "[!] QEMU not found in PATH" -ForegroundColor $ErrorColor
    Write-Host "[!] Please install QEMU from: https://qemu.weilnetz.de/w64/" -ForegroundColor $WarningColor
    Write-Host "[!] After installation, add QEMU to your PATH or run from QEMU directory" -ForegroundColor $WarningColor
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "[+] QEMU found: $($qemuPath.Source)" -ForegroundColor $SuccessColor

# Check for ISO
Write-Host "[*] Checking for AVIOS ISO..." -ForegroundColor $InfoColor
if (-not (Test-Path $IsoPath)) {
    Write-Host "[!] ISO not found: $IsoPath" -ForegroundColor $ErrorColor
    Write-Host "[!] Please ensure avios.iso is in the same directory" -ForegroundColor $WarningColor
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "[+] ISO found: $IsoPath" -ForegroundColor $SuccessColor
$isoSize = [math]::Round((Get-Item $IsoPath).Length / 1MB, 2)
Write-Host "[+] ISO size: $isoSize MB" -ForegroundColor $SuccessColor

# Display configuration
Write-Host ""
Write-Host ("=" * 50) -ForegroundColor $InfoColor
Write-Host "VIRTUAL MACHINE CONFIGURATION" -ForegroundColor $InfoColor
Write-Host ("=" * 50) -ForegroundColor $InfoColor
Write-Host "  Memory (RAM):    $Memory MB" -ForegroundColor $InfoColor
Write-Host "  CPU Cores:       $CPUs" -ForegroundColor $InfoColor
Write-Host "  Boot Device:     CD-ROM (ISO)" -ForegroundColor $InfoColor
Write-Host "  Graphics:        VirtIO" -ForegroundColor $InfoColor
Write-Host "  Network:         NAT (User Mode)" -ForegroundColor $InfoColor
Write-Host "  USB:             Enabled (Tablet)" -ForegroundColor $InfoColor
if ($Fullscreen) {
    Write-Host "  Display Mode:    Fullscreen" -ForegroundColor $InfoColor
}
if ($EnableAccel) {
    Write-Host "  Acceleration:    WHPX (Hyper-V Platform)" -ForegroundColor $InfoColor
}
Write-Host ("=" * 50) -ForegroundColor $InfoColor
Write-Host ""

# Keyboard shortcuts help
Write-Host "KEYBOARD SHORTCUTS:" -ForegroundColor $WarningColor
Write-Host "  Ctrl + Alt + G  : Release/capture mouse" -ForegroundColor $InfoColor
Write-Host "  Ctrl + Alt + F  : Toggle fullscreen" -ForegroundColor $InfoColor
Write-Host "  Ctrl + Alt + Q  : Quit QEMU" -ForegroundColor $InfoColor
Write-Host ""

Write-Host "[*] Starting AVIOS in 3 seconds..." -ForegroundColor $SuccessColor
Start-Sleep -Seconds 3

# Build QEMU command
$qemuArgs = @(
    "-m", $Memory,
    "-smp", $CPUs,
    "-cdrom", $IsoPath,
    "-boot", "d",
    "-vga", "virtio",
    "-usb",
    "-device", "usb-tablet",
    "-net", "nic,model=virtio",
    "-net", "user",
    "-name", "AVIOS - Advanced Virtualized Intelligence OS",
    "-rtc", "base=localtime"
)

# Add display options
if ($Fullscreen) {
    $qemuArgs += "-display", "sdl,gl=on", "-full-screen"
} else {
    $qemuArgs += "-display", "sdl,gl=on"
}

# Add acceleration if requested
if ($EnableAccel) {
    $qemuArgs += "-accel", "whpx"
}

# Launch QEMU
try {
    Write-Host "[+] Launching AVIOS..." -ForegroundColor $SuccessColor
    Write-Host ""
    
    & qemu-system-x86_64.exe $qemuArgs
    
    $exitCode = $LASTEXITCODE
    
    Write-Host ""
    if ($exitCode -eq 0) {
        Write-Host "[+] AVIOS session ended normally" -ForegroundColor $SuccessColor
    } else {
        Write-Host "[!] QEMU exited with code: $exitCode" -ForegroundColor $WarningColor
    }
}
catch {
    Write-Host "[!] Error launching QEMU: $_" -ForegroundColor $ErrorColor
}

Write-Host ""
Write-Host "Press Enter to exit..."
Read-Host
