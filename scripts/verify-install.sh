#!/bin/bash
# AVIOS Installation Verification
# Checks if AVIOS is properly set up

echo "======================================"
echo "   AVIOS Installation Verification"
echo "======================================"
echo ""

PASS=0
FAIL=0

check_file() {
    if [ -f "$1" ]; then
        echo "✓ $2"
        ((PASS++))
    else
        echo "✗ Missing: $2 ($1)"
        ((FAIL++))
    fi
}

check_dir() {
    if [ -d "$1" ]; then
        echo "✓ $2"
        ((PASS++))
    else
        echo "✗ Missing: $2 ($1)"
        ((FAIL++))
    fi
}

check_command() {
    if command -v "$1" &> /dev/null; then
        echo "✓ $2 installed"
        ((PASS++))
    else
        echo "⚠ $2 not found (optional)"
    fi
}

echo "[1] Checking project structure..."
check_file "README.md" "README.md"
check_file "LICENSE" "LICENSE"
check_dir "ui" "UI directory"
check_dir "tools" "Tools directory"
check_dir "scripts" "Scripts directory"
check_dir "kernel" "Kernel configuration"
check_dir "bootloader" "Bootloader configuration"

echo ""
echo "[2] Checking UI files..."
check_file "ui/desktop.html" "Desktop HTML"
check_file "ui/style.css" "CSS Stylesheet"
check_file "ui/desktop.js" "JavaScript"

echo ""
echo "[3] Checking documentation..."
check_file "QUICK_START.md" "Quick Start Guide"
check_file "WINDOWS_SETUP_GUIDE.md" "Windows Setup Guide"
check_file "FAQ.md" "FAQ"
check_file "tools/TOOLS_REFERENCE.md" "Tools Reference"
check_file "PROJECT_STRUCTURE.md" "Project Structure"
check_file "CHANGELOG.md" "Changelog"

echo ""
echo "[4] Checking scripts..."
check_file "scripts/build-system.sh" "Build script"
check_file "scripts/test-ui.sh" "UI test script"
check_file "scripts/quick-build.sh" "Quick build script"
check_file "run-avios.bat" "AVIOS launcher (batch)"
check_file "run-avios.ps1" "AVIOS launcher (PowerShell)"
check_file "test-ui.bat" "UI test (batch)"

echo ""
echo "[5] Checking optional dependencies..."
check_command "python3" "Python 3"
check_command "qemu-system-x86_64" "QEMU"
check_command "debootstrap" "debootstrap"
check_command "squashfs-tools" "SquashFS tools"

echo ""
echo "======================================"
echo "   Verification Results"
echo "======================================"
echo "✓ Checks passed: $PASS"
echo "✗ Checks failed: $FAIL"
echo ""

if [ $FAIL -eq 0 ]; then
    echo "✓ AVIOS installation verified!"
    echo ""
    echo "Next steps:"
    echo "  1. Read QUICK_START.md"
    echo "  2. Run test-ui.bat (Windows) or ./scripts/test-ui.sh (Linux)"
    echo "  3. For full build: sudo ./scripts/build-system.sh"
else
    echo "⚠ Some files are missing!"
    echo "Please check that all files were extracted correctly."
fi

echo ""
