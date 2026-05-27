# AVIOS Project Structure

```
avios-project/
│
├── README.md                    # Main project documentation
├── QUICK_START.md               # Quick start guide for users
├── WINDOWS_SETUP_GUIDE.md       # Detailed Windows setup instructions
├── FAQ.md                       # Frequently asked questions
├── LICENSE                      # MIT License and disclaimers
│
├── kernel/                      # Kernel configuration
│   └── avios-kernel.config      # Custom Linux kernel config
│
├── bootloader/                  # Boot configuration
│   └── grub.cfg                 # GRUB bootloader settings
│
├── ui/                          # Desktop environment (can run standalone!)
│   ├── desktop.html             # Main desktop interface
│   ├── style.css                # Modern hacker-themed styles
│   └── desktop.js               # Desktop functionality & terminal
│
├── rootfs/                      # Root filesystem structure
│   └── [Created during build]   # System files and directories
│
├── tools/                       # Security tools
│   ├── install-tools.sh         # Tool installation script
│   └── TOOLS_REFERENCE.md       # Complete tool documentation
│
├── scripts/                     # Build and automation scripts
│   ├── build-system.sh          # Main build script (creates full ISO)
│   ├── quick-build.sh           # Quick demo build
│   └── test-ui.sh               # UI test server (Linux/Mac)
│
├── iso-build/                   # ISO creation workspace
│   └── [Created during build]   # Temporary build files
│
├── run-avios.bat                # Windows launcher (batch)
├── run-avios.ps1                # Windows launcher (PowerShell, advanced)
├── test-ui.bat                  # UI test server (Windows)
│
└── [Generated files]
    ├── avios.iso                # Full bootable ISO (after build)
    └── avios-demo.iso           # Quick demo ISO (after quick-build)
```

## Key Components

### User-Facing Files

#### For Windows Users
- `run-avios.bat` - Simple double-click launcher
- `run-avios.ps1` - Advanced PowerShell launcher with options
- `test-ui.bat` - Test UI in browser without QEMU
- `WINDOWS_SETUP_GUIDE.md` - Complete Windows setup guide
- `QUICK_START.md` - Fast getting started guide

#### Documentation
- `README.md` - Project overview and features
- `FAQ.md` - Common questions and answers
- `tools/TOOLS_REFERENCE.md` - How to use each security tool
- `LICENSE` - Legal information and disclaimers

### Development Files

#### Build System
- `scripts/build-system.sh` - Creates full bootable Linux ISO
- `scripts/quick-build.sh` - Creates quick demo
- `scripts/test-ui.sh` - Runs UI test server

#### Configuration
- `kernel/avios-kernel.config` - Linux kernel configuration
- `bootloader/grub.cfg` - GRUB boot configuration
- `tools/install-tools.sh` - Security tools installer

#### User Interface
- `ui/desktop.html` - Main UI structure
- `ui/style.css` - Modern cyber-themed styling
- `ui/desktop.js` - Desktop functionality and terminal emulation

## File Sizes (Approximate)

- Source files: ~5 MB
- Built ISO: 1-2 GB (depending on tools installed)
- Runtime (QEMU): 2-4 GB RAM usage

## Build Artifacts

After running `build-system.sh`:
```
iso-build/
├── rootfs/          # Full Linux root filesystem (~2 GB)
└── iso/             # ISO staging directory
    ├── boot/        # Kernel and bootloader
    └── live/        # Live system files

avios.iso            # Final bootable ISO (~1.5 GB)
```

After running `quick-build.sh`:
```
quick-iso/           # Demo ISO contents
avios-demo.iso       # Demo ISO file (~50 MB)
```

## Customization Points

### UI Customization
Edit files in `ui/` directory:
- `desktop.html` - Add/remove UI elements
- `style.css` - Change colors, fonts, layouts
- `desktop.js` - Modify behavior and features

### Tool Selection
Edit `tools/install-tools.sh`:
- Add/remove tools from apt-get install lines
- Add custom tool installation commands
- Configure tool defaults

### Kernel Configuration
Edit `kernel/avios-kernel.config`:
- Enable/disable kernel modules
- Add driver support
- Tune performance settings

### Boot Configuration
Edit `bootloader/grub.cfg`:
- Add boot menu entries
- Change boot parameters
- Customize appearance

## Dependencies

### Build Dependencies (Linux)
- debootstrap
- squashfs-tools
- xorriso
- grub-pc-bin
- grub-efi-amd64-bin
- build-essential
- And more (installed by build-system.sh)

### Runtime Dependencies (Windows)
- QEMU (required for running VM)
- Python 3 (optional, for UI testing)

## Development Workflow

### Testing UI Changes
1. Edit files in `ui/`
2. Run `test-ui.bat` (Windows) or `./scripts/test-ui.sh` (Linux)
3. Open `http://localhost:8080/desktop.html`
4. Refresh browser to see changes
5. No rebuild needed!

### Building Full ISO
1. Make desired changes
2. Run `sudo ./scripts/build-system.sh`
3. Wait 30-60 minutes
4. Test with `run-avios.bat`

### Quick Testing
1. Run `./scripts/quick-build.sh`
2. Much faster than full build
3. Good for testing basic functionality

## Version Control

Recommended `.gitignore`:
```
iso-build/
rootfs/
quick-iso/
*.iso
*.qcow2
*.log
```

## Distribution

### For End Users
Distribute:
- `avios.iso` (or download link)
- `run-avios.bat`
- `run-avios.ps1`
- `QUICK_START.md`
- `WINDOWS_SETUP_GUIDE.md`
- `LICENSE`

### For Developers
Distribute entire project:
- All source files
- Build scripts
- Documentation
- Examples and templates

## Maintenance

### Regular Updates
```bash
# Update security tools
apt-get update
apt-get upgrade

# Rebuild ISO with updates
sudo ./scripts/build-system.sh
```

### Version Numbering
Suggested format: `MAJOR.MINOR.PATCH`
- MAJOR: Major feature additions or breaking changes
- MINOR: New tools or significant improvements
- PATCH: Bug fixes and minor updates

## Contributing

### Areas for Contribution
1. **Additional tools** - Integrate more security tools
2. **UI improvements** - Enhance desktop environment
3. **Documentation** - Improve guides and tutorials
4. **Bug fixes** - Fix issues and improve stability
5. **Performance** - Optimize build and runtime
6. **Platform support** - Improve macOS/Linux support

### Development Setup
```bash
git clone [repository]
cd avios-project
./scripts/test-ui.sh  # Test UI
sudo ./scripts/build-system.sh  # Full build
```

## Support Files

### Included Examples
- Sample terminal commands
- Tool usage examples
- Configuration templates
- Keyboard shortcuts reference

### Not Included (User Provides)
- Virtual disk images
- Custom wordlists
- Additional tools not in default install
- Personal configurations

## Security Considerations

### What's Secured
- Minimal attack surface
- Security-focused kernel config
- Latest package versions (at build time)

### What's Not Secured
- No passwords by default (live system)
- Tools have full privileges
- Not hardened for production use
- Designed for testing, not as daily driver

### Recommendations
- Set strong passwords after first boot
- Use only in isolated test environments
- Keep tools updated regularly
- Follow ethical hacking guidelines
- Never test production systems without authorization

## Performance Notes

### Build Performance
- SSD recommended for building
- 8GB+ RAM for faster builds
- Multi-core CPU helps
- Fast internet for downloads

### Runtime Performance
- 2GB RAM minimum, 4GB+ recommended
- 2+ CPU cores for good experience
- VirtIO drivers for best performance
- SSD storage for virtual disks

## Troubleshooting Build Issues

### Common Build Problems
1. **Insufficient disk space** - Need 20GB+ free
2. **Network issues** - Check internet connection
3. **Permission errors** - Run with sudo
4. **Missing dependencies** - Script installs them
5. **Long build time** - Normal, can take 30-60 min

### Build Logs
Check `/tmp/` for build logs if issues occur.

## Future Enhancements

### Planned Features
- Persistent storage improvements
- More tool integrations
- Enhanced UI features
- Better hardware support
- Cloud integration options
- Container support

### Community Requests
Monitor GitHub issues for user requests and prioritize based on:
- Security value
- User demand
- Implementation complexity
- Maintenance burden
