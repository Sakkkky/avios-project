#!/bin/bash
# AVIOS Security Tools Installation Script
# Installs Kali Linux penetration testing tools

set -e

echo "======================================"
echo "   AVIOS Security Tools Installer"
echo "======================================"
echo ""

# Check if running in AVIOS or as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root (use sudo)"
    exit 1
fi

export DEBIAN_FRONTEND=noninteractive

echo "[1/10] Updating package repositories..."
apt-get update -qq

echo "[2/10] Installing network analysis tools..."
apt-get install -y --no-install-recommends \
    nmap \
    masscan \
    zmap \
    netcat-traditional \
    netcat-openbsd \
    tcpdump \
    wireshark \
    tshark \
    ettercap-text-only \
    dsniff \
    arpwatch \
    > /dev/null 2>&1

echo "[3/10] Installing web application testing tools..."
apt-get install -y --no-install-recommends \
    nikto \
    sqlmap \
    wpscan \
    dirb \
    gobuster \
    wfuzz \
    whatweb \
    > /dev/null 2>&1

echo "[4/10] Installing password cracking tools..."
apt-get install -y --no-install-recommends \
    john \
    hashcat \
    hydra \
    medusa \
    ncrack \
    ophcrack \
    > /dev/null 2>&1

echo "[5/10] Installing wireless tools..."
apt-get install -y --no-install-recommends \
    aircrack-ng \
    reaver \
    bully \
    pixiewps \
    hostapd \
    dnsmasq \
    > /dev/null 2>&1

echo "[6/10] Installing exploitation frameworks..."
# Note: Metasploit requires manual installation from rapid7
apt-get install -y --no-install-recommends \
    exploitdb \
    armitage \
    beef-xss \
    > /dev/null 2>&1

echo "[7/10] Installing forensics tools..."
apt-get install -y --no-install-recommends \
    binwalk \
    foremost \
    volatility \
    autopsy \
    sleuthkit \
    > /dev/null 2>&1

echo "[8/10] Installing reverse engineering tools..."
apt-get install -y --no-install-recommends \
    radare2 \
    gdb \
    strace \
    ltrace \
    objdump \
    > /dev/null 2>&1

echo "[9/10] Installing information gathering tools..."
apt-get install -y --no-install-recommends \
    whois \
    dnsutils \
    traceroute \
    theharvester \
    recon-ng \
    maltego \
    > /dev/null 2>&1

echo "[10/10] Installing additional utilities..."
apt-get install -y --no-install-recommends \
    git \
    python3 \
    python3-pip \
    python3-dev \
    ruby \
    ruby-dev \
    golang \
    default-jdk \
    > /dev/null 2>&1

# Install Python security libraries
echo "Installing Python security libraries..."
pip3 install --quiet \
    scapy \
    pwntools \
    requests \
    beautifulsoup4 \
    impacket \
    pycryptodome \
    > /dev/null 2>&1

# Install additional tools via GitHub
echo "Installing additional tools from repositories..."

# Install Metasploit Framework
if [ ! -d "/opt/metasploit-framework" ]; then
    echo "  - Installing Metasploit Framework..."
    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > /tmp/msfinstall
    chmod +x /tmp/msfinstall
    /tmp/msfinstall > /dev/null 2>&1 || echo "  ! Metasploit installation failed (manual install required)"
fi

# Install Burp Suite Community
if [ ! -f "/opt/burpsuite/burpsuite.jar" ]; then
    echo "  - Installing Burp Suite (community edition)..."
    mkdir -p /opt/burpsuite
    # Note: Actual download requires accepting terms, placeholder here
    echo "  ! Burp Suite requires manual download from portswigger.net"
fi

# Clean up
echo "Cleaning up..."
apt-get autoremove -y > /dev/null 2>&1
apt-get clean > /dev/null 2>&1
rm -rf /var/lib/apt/lists/*

echo ""
echo "======================================"
echo "   Installation Complete!"
echo "======================================"
echo ""
echo "Installed tool categories:"
echo "  ✓ Network Analysis"
echo "  ✓ Web Application Testing"
echo "  ✓ Password Cracking"
echo "  ✓ Wireless Security"
echo "  ✓ Exploitation Frameworks"
echo "  ✓ Forensics"
echo "  ✓ Reverse Engineering"
echo "  ✓ Information Gathering"
echo ""
echo "Note: Some tools (Burp Suite, Metasploit) may require"
echo "additional configuration or manual installation."
echo ""
