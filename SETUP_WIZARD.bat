@echo off
REM ============================================================
REM AVIOS COMPLETE SETUP WIZARD FOR WINDOWS 11
REM ============================================================
REM This script will guide you through the entire setup
REM No technical knowledge required!
REM ============================================================

setlocal enabledelayedexpansion
cd /d "%~dp0"

:menu
cls
echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║                                                            ║
echo ║          AVIOS COMPLETE SETUP WIZARD                       ║
echo ║                                                            ║
echo ║   Advanced Virtualized Intelligence Operating System      ║
echo ║                                                            ║
echo ╚════════════════════════════════════════════════════════════╝
echo.
echo Choose what you want to do:
echo.
echo 1. Test AVIOS UI in browser (30 seconds) - QUICK TEST
echo 2. Setup QEMU and run full AVIOS (recommended)
echo 3. Check if everything is installed
echo 4. View documentation
echo 5. Exit
echo.
set /p choice="Enter your choice (1-5): "

if "%choice%"=="1" goto ui_test
if "%choice%"=="2" goto setup_qemu
if "%choice%"=="3" goto check_install
if "%choice%"=="4" goto view_docs
if "%choice%"=="5" goto end
goto menu

REM ============================================================
REM OPTION 1: TEST UI
REM ============================================================
:ui_test
cls
echo.
echo ════════════════════════════════════════════════════════════
echo TESTING AVIOS UI IN BROWSER
echo ════════════════════════════════════════════════════════════
echo.

REM Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Python is not installed!
    echo.
    echo To install Python:
    echo 1. Download from: https://www.python.org/downloads/
    echo 2. Run installer
    echo 3. Check "Add Python to PATH"
    echo 4. Try again
    echo.
    pause
    goto menu
)

echo ✓ Python found
echo.
echo Starting HTTP server...
echo.
echo Opening browser to: http://localhost:8080/desktop.html
echo.
echo Press Ctrl+C to stop the server when done
echo.
timeout /t 2

cd ui
python -m http.server 8080
cd ..
goto menu

REM ============================================================
REM OPTION 2: SETUP QEMU AND RUN FULL OS
REM ============================================================
:setup_qemu
cls
echo.
echo ════════════════════════════════════════════════════════════
echo AVIOS QEMU SETUP
echo ════════════════════════════════════════════════════════════
echo.

REM Check if QEMU is installed
qemu-system-x86_64.exe --version >nul 2>&1
if %errorlevel% neq 0 (
    echo QEMU is not installed
    echo.
    echo Would you like to:
    echo 1. Download QEMU installer (opens browser)
    echo 2. Install QEMU manually
    echo 3. Go back
    echo.
    set /p qemu_choice="Enter choice (1-3): "
    
    if "!qemu_choice!"=="1" (
        echo Opening QEMU download page...
        start https://qemu.weilnetz.de/w64/
        echo.
        echo After downloading and installing QEMU:
        echo 1. Add QEMU to PATH (see documentation)
        echo 2. Run this script again
        echo.
        pause
        goto menu
    )
    if "!qemu_choice!"=="2" (
        cls
        type WINDOWS_SETUP_GUIDE.md
        echo.
        pause
        goto menu
    )
    goto menu
)

echo ✓ QEMU found!
echo.
echo Checking for avios.iso...
if exist "avios.iso" (
    echo ✓ ISO found
    echo.
    echo Starting AVIOS...
    echo.
    timeout /t 2
    call run-avios.bat
) else (
    echo WARNING: avios.iso not found
    echo.
    echo You need to:
    echo 1. Build the ISO: run build script
    echo 2. Or download pre-built ISO
    echo.
    echo For now, using bootable USB/CD mode...
    echo.
    pause
    goto menu
)
goto menu

REM ============================================================
REM OPTION 3: CHECK INSTALLATION
REM ============================================================
:check_install
cls
echo.
echo ════════════════════════════════════════════════════════════
echo CHECKING INSTALLATION
echo ════════════════════════════════════════════════════════════
echo.

echo Checking for required files...
echo.

set missing=0

if exist "ui\desktop.html" (
    echo ✓ UI files found
) else (
    echo ✗ UI files missing
    set /a missing=!missing!+1
)

if exist "scripts\build-system.sh" (
    echo ✓ Build scripts found
) else (
    echo ✗ Build scripts missing
    set /a missing=!missing!+1
)

if exist "tools\TOOLS_REFERENCE.md" (
    echo ✓ Tools reference found
) else (
    echo ✗ Tools reference missing
    set /a missing=!missing!+1
)

if exist "START_HERE.md" (
    echo ✓ Documentation found
) else (
    echo ✗ Documentation missing
    set /a missing=!missing!+1
)

python --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ Python 3 installed
) else (
    echo ⚠ Python 3 not found (optional)
)

qemu-system-x86_64.exe --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ QEMU installed
) else (
    echo ⚠ QEMU not found (needed to run full OS)
)

echo.
if %missing% equ 0 (
    echo ✓ ALL FILES PRESENT
    echo.
    echo You can:
    echo - Test UI: Option 1
    echo - Run full OS: Option 2 (needs QEMU)
) else (
    echo ✗ SOME FILES MISSING
    echo Please re-extract the project
)

echo.
pause
goto menu

REM ============================================================
REM OPTION 4: VIEW DOCUMENTATION
REM ============================================================
:view_docs
cls
echo.
echo ════════════════════════════════════════════════════════════
echo DOCUMENTATION VIEWER
echo ════════════════════════════════════════════════════════════
echo.
echo Which document would you like to read?
echo.
echo 1. START_HERE.md (Quick orientation)
echo 2. QUICK_START.md (5-minute setup)
echo 3. WINDOWS_SETUP_GUIDE.md (Detailed setup)
echo 4. FAQ.md (Questions and answers)
echo 5. Back to menu
echo.
set /p doc_choice="Enter choice (1-5): "

if "!doc_choice!"=="1" (
    if exist "START_HERE.md" (
        type START_HERE.md | more
    ) else (
        echo File not found
    )
)
if "!doc_choice!"=="2" (
    if exist "QUICK_START.md" (
        type QUICK_START.md | more
    ) else (
        echo File not found
    )
)
if "!doc_choice!"=="3" (
    if exist "WINDOWS_SETUP_GUIDE.md" (
        type WINDOWS_SETUP_GUIDE.md | more
    ) else (
        echo File not found
    )
)
if "!doc_choice!"=="4" (
    if exist "FAQ.md" (
        type FAQ.md | more
    ) else (
        echo File not found
    )
)

goto view_docs

REM ============================================================
REM END
REM ============================================================
:end
cls
echo.
echo ════════════════════════════════════════════════════════════
echo Thank you for using AVIOS!
echo ════════════════════════════════════════════════════════════
echo.
echo Next steps:
echo 1. Read START_HERE.md
echo 2. Choose your path:
echo    - Test UI (30 seconds)
echo    - Run full OS (with QEMU)
echo    - Build custom OS (advanced)
echo.
echo For help: See FAQ.md or WINDOWS_SETUP_GUIDE.md
echo.
echo Happy ethical hacking! 🔐
echo.
pause
exit /b 0
