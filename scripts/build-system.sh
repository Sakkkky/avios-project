#!/bin/bash
# AVIOS Build Script
# Builds a bootable ISO image with custom Linux kernel and UI

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
BUILD_DIR="$PROJECT_ROOT/iso-build"
ROOTFS_DIR="$BUILD_DIR/rootfs"
ISO_DIR="$BUILD_DIR/iso"

echo "======================================"
echo "   AVIOS Build System v1.0"
echo "======================================"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root (use sudo)"
    exit 1
fi

# Install required packages
echo "[1/8] Installing build dependencies..."
apt-get update -qq
apt-get install -y \
    debootstrap \
    squashfs-tools \
    xorriso \
    isolinux \
    syslinux-efi \
    grub-pc-bin \
    grub-efi-amd64-bin \
    mtools \
    wget \
    git \
    build-essential \
    bc \
    kmod \
    cpio \
    flex \
    libncurses5-dev \
    libelf-dev \
    libssl-dev \
    > /dev/null 2>&1

echo "✓ Dependencies installed"

# Create build directories
echo "[2/8] Creating build directories..."
mkdir -p "$BUILD_DIR"
mkdir -p "$ROOTFS_DIR"
mkdir -p "$ISO_DIR"
mkdir -p "$ISO_DIR/boot/grub"
mkdir -p "$ISO_DIR/live"

echo "✓ Directories created"

# Build minimal root filesystem
echo "[3/8] Building root filesystem (this may take a while)..."
if [ ! -d "$ROOTFS_DIR/usr" ]; then
    debootstrap --arch=amd64 --variant=minbase jammy "$ROOTFS_DIR" http://archive.ubuntu.com/ubuntu/ > /dev/null 2>&1
fi

echo "✓ Base system installed"

# Configure the system
echo "[4/8] Configuring system..."

# Set hostname
echo "avios" > "$ROOTFS_DIR/etc/hostname"

# Configure network
cat > "$ROOTFS_DIR/etc/hosts" << EOF
127.0.0.1   localhost avios
::1         localhost ip6-localhost ip6-loopback
EOF

# Configure DNS
cat > "$ROOTFS_DIR/etc/resolv.conf" << EOF
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF

# Create root user with no password (for live system)
chroot "$ROOTFS_DIR" /bin/bash -c "passwd -d root" > /dev/null 2>&1

echo "✓ System configured"

# Install essential packages in chroot
echo "[5/8] Installing system packages..."
cat > "$ROOTFS_DIR/tmp/install-packages.sh" << 'PKGEOF'
#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -y --no-install-recommends \
    linux-generic \
    systemd \
    systemd-sysv \
    network-manager \
    sudo \
    nano \
    vim \
    curl \
    wget \
    net-tools \
    iputils-ping \
    iproute2 \
    ca-certificates \
    openssl \
    openssh-client \
    git \
    build-essential \
    python3 \
    python3-pip \
    nmap \
    tcpdump \
    netcat \
    dnsutils \
    whois \
    traceroute \
    firefox \
    xorg \
    xinit \
    openbox \
    lightdm \
    > /dev/null 2>&1

# Clean up
apt-get clean
rm -rf /var/lib/apt/lists/*
PKGEOF

chmod +x "$ROOTFS_DIR/tmp/install-packages.sh"
chroot "$ROOTFS_DIR" /tmp/install-packages.sh

echo "✓ Packages installed"

# Install AVIOS UI
echo "[6/8] Installing AVIOS desktop environment..."
mkdir -p "$ROOTFS_DIR/opt/avios"
cp -r "$PROJECT_ROOT/ui/"* "$ROOTFS_DIR/opt/avios/"

# Create startup script
cat > "$ROOTFS_DIR/usr/local/bin/start-avios" << 'EOF'
#!/bin/bash
cd /opt/avios
python3 -m http.server 8080 &
PYTHON_PID=$!

sleep 2
firefox --kiosk http://localhost:8080/desktop.html &

wait $PYTHON_PID
EOF

chmod +x "$ROOTFS_DIR/usr/local/bin/start-avios"

# Create systemd service for AVIOS
cat > "$ROOTFS_DIR/etc/systemd/system/avios-desktop.service" << EOF
[Unit]
Description=AVIOS Desktop Environment
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/start-avios
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

# Enable AVIOS service
chroot "$ROOTFS_DIR" systemctl enable avios-desktop.service > /dev/null 2>&1

echo "✓ AVIOS UI installed"

# Create initramfs
echo "[7/8] Creating initramfs..."
chroot "$ROOTFS_DIR" update-initramfs -c -k all > /dev/null 2>&1

# Copy kernel and initramfs to ISO
KERNEL=$(ls "$ROOTFS_DIR/boot/vmlinuz-"* | head -n1)
INITRD=$(ls "$ROOTFS_DIR/boot/initrd.img-"* | head -n1)

cp "$KERNEL" "$ISO_DIR/live/vmlinuz"
cp "$INITRD" "$ISO_DIR/live/initrd"

echo "✓ Kernel and initramfs ready"

# Create squashfs
echo "[8/8] Creating bootable ISO..."
mksquashfs "$ROOTFS_DIR" "$ISO_DIR/live/filesystem.squashfs" -comp xz -b 1M > /dev/null 2>&1

# Create GRUB configuration
cat > "$ISO_DIR/boot/grub/grub.cfg" << 'EOF'
set timeout=5
set default=0

menuentry "AVIOS - Advanced Virtualized Intelligence OS" {
    linux /live/vmlinuz boot=live quiet splash
    initrd /live/initrd
}

menuentry "AVIOS - Safe Mode" {
    linux /live/vmlinuz boot=live single
    initrd /live/initrd
}
EOF

# Create ISO
grub-mkrescue -o "$PROJECT_ROOT/avios.iso" "$ISO_DIR" > /dev/null 2>&1

echo "✓ ISO created successfully"
echo ""
echo "======================================"
echo "   Build Complete!"
echo "======================================"
echo ""
echo "ISO Location: $PROJECT_ROOT/avios.iso"
echo "ISO Size: $(du -h "$PROJECT_ROOT/avios.iso" | cut -f1)"
echo ""
echo "You can now run AVIOS with:"
echo "  qemu-system-x86_64 -m 2048 -cdrom avios.iso -boot d"
echo ""
