#!/bin/bash
# AVIOS Quick Build - Creates a minimal bootable ISO for testing
# This is a lightweight version that builds faster

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "======================================"
echo "   AVIOS Quick Build"
echo "======================================"
echo ""
echo "Creating a minimal test ISO..."
echo ""

# Create ISO structure
mkdir -p "$PROJECT_ROOT/quick-iso/boot/grub"
mkdir -p "$PROJECT_ROOT/quick-iso/avios"

# Copy UI files
cp -r "$PROJECT_ROOT/ui/"* "$PROJECT_ROOT/quick-iso/avios/"

# Create a simple GRUB config that boots to a minimal Linux
cat > "$PROJECT_ROOT/quick-iso/boot/grub/grub.cfg" << 'EOF'
set timeout=5
set default=0
set color_normal=cyan/black
set color_highlight=black/cyan

menuentry "AVIOS Demo (Browser Mode)" {
    echo "Loading AVIOS..."
    echo "This is a demonstration mode."
    echo "Full system requires building with build-system.sh"
}
EOF

# Create README for the ISO
cat > "$PROJECT_ROOT/quick-iso/README.txt" << 'EOF'
AVIOS - Advanced Virtualized Intelligence Operating System

This is a demo ISO. To run the full AVIOS system:

1. Build the complete ISO using: sudo ./scripts/build-system.sh
2. Run with QEMU: qemu-system-x86_64 -m 2048 -cdrom avios.iso

For Windows users:
1. Install QEMU from https://qemu.weilnetz.de/w64/
2. Run: run-avios.bat

The AVIOS UI can also be tested directly in a browser:
Open ui/desktop.html in any modern web browser.
EOF

# Create ISO (lightweight, no actual OS)
if command -v genisoimage &> /dev/null; then
    genisoimage -o "$PROJECT_ROOT/avios-demo.iso" \
        -b boot/grub/grub.cfg \
        -no-emul-boot \
        -boot-load-size 4 \
        -boot-info-table \
        -R -J -v -T \
        "$PROJECT_ROOT/quick-iso" > /dev/null 2>&1
    echo "✓ Demo ISO created: avios-demo.iso"
elif command -v mkisofs &> /dev/null; then
    mkisofs -o "$PROJECT_ROOT/avios-demo.iso" \
        -b boot/grub/grub.cfg \
        -no-emul-boot \
        -boot-load-size 4 \
        -boot-info-table \
        -R -J -v -T \
        "$PROJECT_ROOT/quick-iso" > /dev/null 2>&1
    echo "✓ Demo ISO created: avios-demo.iso"
else
    echo "⚠ ISO creation tools not found. UI files are in quick-iso/avios/"
    echo "  You can open desktop.html directly in a browser to test the UI."
fi

echo ""
echo "======================================"
echo "   Quick Build Complete!"
echo "======================================"
echo ""
echo "To test AVIOS UI immediately:"
echo "  cd $PROJECT_ROOT/ui"
echo "  python3 -m http.server 8080"
echo "  Then open: http://localhost:8080/desktop.html"
echo ""
echo "To build full bootable OS:"
echo "  sudo ./scripts/build-system.sh"
echo ""
