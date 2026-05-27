@echo off
REM AVIOS Launcher for Windows 11
REM Runs AVIOS in QEMU emulator

echo ========================================
echo    AVIOS Launcher for Windows
echo ========================================
echo.

REM Check if QEMU is installed
where qemu-system-x86_64.exe >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: QEMU is not installed or not in PATH
    echo.
    echo Please install QEMU from: https://qemu.weilnetz.de/w64/
    echo After installation, add QEMU to your PATH or run this script from QEMU directory
    echo.
    pause
    exit /b 1
)

REM Check if ISO exists
if not exist "avios.iso" (
    echo ERROR: avios.iso not found in current directory
    echo.
    echo Please ensure avios.iso is in the same directory as this script
    echo.
    pause
    exit /b 1
)

echo Starting AVIOS...
echo.
echo VM Configuration:
echo   RAM: 2048 MB
echo   CPUs: 2 cores
echo   Display: VirtIO
echo   Boot: CD-ROM (avios.iso)
echo.
echo Press Ctrl+Alt+G to release mouse cursor
echo Press Ctrl+Alt+F to toggle fullscreen
echo.

REM Launch QEMU with optimal settings for AVIOS
qemu-system-x86_64.exe ^
    -m 2048 ^
    -smp 2 ^
    -cdrom avios.iso ^
    -boot d ^
    -vga virtio ^
    -display sdl,gl=on ^
    -usb ^
    -device usb-tablet ^
    -net nic,model=virtio ^
    -net user ^
    -name "AVIOS - Advanced Virtualized Intelligence OS" ^
    -rtc base=localtime

if %errorlevel% neq 0 (
    echo.
    echo QEMU exited with error code: %errorlevel%
    echo.
    pause
)
