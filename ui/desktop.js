// AVIOS Desktop Environment JavaScript

class AVIOSDesktop {
    constructor() {
        this.windows = [];
        this.windowCounter = 0;
        this.activeWindow = null;
        this.bootSequence();
    }

    bootSequence() {
        const messages = [
            'Initializing AVIOS kernel...',
            'Loading security modules...',
            'Mounting file systems...',
            'Starting network services...',
            'Initializing display manager...',
            'Loading desktop environment...',
            'AVIOS ready.'
        ];

        let index = 0;
        const bootMessage = document.getElementById('boot-message');
        
        const interval = setInterval(() => {
            if (index < messages.length) {
                bootMessage.textContent = messages[index];
                index++;
            } else {
                clearInterval(interval);
                setTimeout(() => this.startDesktop(), 500);
            }
        }, 400);
    }

    startDesktop() {
        document.getElementById('boot-sequence').classList.add('hidden');
        document.getElementById('desktop').classList.remove('hidden');
        this.initializeDesktop();
    }

    initializeDesktop() {
        this.updateClock();
        setInterval(() => this.updateClock(), 1000);
        
        this.simulateSystemStats();
        setInterval(() => this.simulateSystemStats(), 2000);
        
        this.initializeNetworkViz();
        this.attachEventListeners();
        
        // Auto-open terminal on startup
        setTimeout(() => this.openTerminal(), 500);
    }

    updateClock() {
        const now = new Date();
        const timeString = now.toLocaleTimeString('en-US', { hour12: false });
        document.getElementById('clock').textContent = timeString;
    }

    simulateSystemStats() {
        const cpu = Math.floor(Math.random() * 30) + 10;
        const ram = Math.floor(Math.random() * 40) + 20;
        const net = Math.floor(Math.random() * 500) + 100;
        
        document.getElementById('cpu-usage').textContent = `${cpu}%`;
        document.getElementById('ram-usage').textContent = `${ram}%`;
        document.getElementById('net-usage').textContent = `${net} KB/s`;
    }

    initializeNetworkViz() {
        const canvas = document.getElementById('network-canvas');
        const ctx = canvas.getContext('2d');
        
        canvas.width = canvas.offsetWidth;
        canvas.height = canvas.offsetHeight;
        
        const nodes = [];
        const connections = [];
        
        // Create nodes
        for (let i = 0; i < 8; i++) {
            nodes.push({
                x: Math.random() * canvas.width,
                y: Math.random() * canvas.height,
                vx: (Math.random() - 0.5) * 0.5,
                vy: (Math.random() - 0.5) * 0.5,
                radius: 3
            });
        }
        
        const animate = () => {
            ctx.fillStyle = 'rgba(10, 14, 39, 0.1)';
            ctx.fillRect(0, 0, canvas.width, canvas.height);
            
            // Update and draw nodes
            nodes.forEach(node => {
                node.x += node.vx;
                node.y += node.vy;
                
                if (node.x < 0 || node.x > canvas.width) node.vx *= -1;
                if (node.y < 0 || node.y > canvas.height) node.vy *= -1;
                
                ctx.beginPath();
                ctx.arc(node.x, node.y, node.radius, 0, Math.PI * 2);
                ctx.fillStyle = '#00ccff';
                ctx.shadowBlur = 10;
                ctx.shadowColor = '#00ccff';
                ctx.fill();
                ctx.shadowBlur = 0;
            });
            
            // Draw connections
            ctx.strokeStyle = 'rgba(0, 204, 255, 0.2)';
            ctx.lineWidth = 1;
            
            for (let i = 0; i < nodes.length; i++) {
                for (let j = i + 1; j < nodes.length; j++) {
                    const dx = nodes[i].x - nodes[j].x;
                    const dy = nodes[i].y - nodes[j].y;
                    const distance = Math.sqrt(dx * dx + dy * dy);
                    
                    if (distance < 100) {
                        ctx.beginPath();
                        ctx.moveTo(nodes[i].x, nodes[i].y);
                        ctx.lineTo(nodes[j].x, nodes[j].y);
                        ctx.stroke();
                    }
                }
            }
            
            requestAnimationFrame(animate);
        };
        
        animate();
    }

    attachEventListeners() {
        // Tool cards
        document.querySelectorAll('.tool-card').forEach(card => {
            card.addEventListener('click', (e) => {
                const tool = e.currentTarget.dataset.tool;
                this.launchTool(tool);
            });
        });
        
        // Dock items
        document.querySelectorAll('.dock-item').forEach(item => {
            item.addEventListener('click', (e) => {
                const app = e.currentTarget.dataset.app;
                this.handleDockClick(app);
            });
        });
        
        // Quick launchers
        document.querySelectorAll('.quick-launch').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const app = e.currentTarget.dataset.app;
                if (app === 'terminal') this.openTerminal();
            });
        });
    }

    handleDockClick(app) {
        document.querySelectorAll('.dock-item').forEach(item => {
            item.classList.remove('active');
        });
        
        event.currentTarget.classList.add('active');
        
        if (app === 'terminal') {
            this.openTerminal();
        } else if (app === 'launcher') {
            // Toggle launcher panel
        }
    }

    launchTool(toolName) {
        this.openTerminal();
        
        const commands = {
            'nmap': 'nmap --help',
            'metasploit': 'msfconsole -h',
            'wireshark': 'wireshark &',
            'burpsuite': 'burpsuite &',
            'john': 'john --help',
            'sqlmap': 'sqlmap --help',
            'aircrack': 'aircrack-ng --help',
            'hashcat': 'hashcat --help'
        };
        
        const command = commands[toolName] || `${toolName} --version`;
        
        setTimeout(() => {
            const input = this.activeWindow.querySelector('.terminal-input');
            if (input) {
                input.value = command;
                const event = new KeyboardEvent('keydown', { key: 'Enter', code: 'Enter' });
                input.dispatchEvent(event);
            }
        }, 300);
    }

    openTerminal() {
        const template = document.getElementById('terminal-template');
        const clone = template.content.cloneNode(true);
        const window = clone.querySelector('.window');
        
        const windowId = `window-${this.windowCounter++}`;
        window.dataset.windowId = windowId;
        
        // Position window
        const offset = this.windows.length * 30;
        window.style.left = `${100 + offset}px`;
        window.style.top = `${50 + offset}px`;
        window.style.width = '700px';
        window.style.height = '500px';
        
        document.getElementById('windows-container').appendChild(window);
        
        this.windows.push(window);
        this.activeWindow = window;
        
        this.makeWindowDraggable(window);
        this.attachWindowControls(window);
        this.initializeTerminal(window);
        
        window.addEventListener('mousedown', () => {
            this.bringToFront(window);
        });
    }

    makeWindowDraggable(window) {
        const header = window.querySelector('.window-header');
        let isDragging = false;
        let currentX, currentY, initialX, initialY;
        
        header.addEventListener('mousedown', (e) => {
            if (e.target.classList.contains('window-btn')) return;
            
            isDragging = true;
            initialX = e.clientX - window.offsetLeft;
            initialY = e.clientY - window.offsetTop;
            
            this.bringToFront(window);
        });
        
        document.addEventListener('mousemove', (e) => {
            if (!isDragging) return;
            
            e.preventDefault();
            currentX = e.clientX - initialX;
            currentY = e.clientY - initialY;
            
            window.style.left = `${currentX}px`;
            window.style.top = `${currentY}px`;
        });
        
        document.addEventListener('mouseup', () => {
            isDragging = false;
        });
    }

    attachWindowControls(window) {
        const closeBtn = window.querySelector('.close');
        const minimizeBtn = window.querySelector('.minimize');
        const maximizeBtn = window.querySelector('.maximize');
        
        closeBtn.addEventListener('click', () => {
            window.style.animation = 'windowPopIn 0.2s reverse';
            setTimeout(() => {
                window.remove();
                this.windows = this.windows.filter(w => w !== window);
            }, 200);
        });
        
        minimizeBtn.addEventListener('click', () => {
            window.style.display = 'none';
        });
        
        let isMaximized = false;
        let originalBounds = {};
        
        maximizeBtn.addEventListener('click', () => {
            if (!isMaximized) {
                originalBounds = {
                    left: window.style.left,
                    top: window.style.top,
                    width: window.style.width,
                    height: window.style.height
                };
                
                window.style.left = '0';
                window.style.top = '40px';
                window.style.width = 'calc(100% - 350px)';
                window.style.height = 'calc(100% - 110px)';
                isMaximized = true;
            } else {
                window.style.left = originalBounds.left;
                window.style.top = originalBounds.top;
                window.style.width = originalBounds.width;
                window.style.height = originalBounds.height;
                isMaximized = false;
            }
        });
    }

    bringToFront(window) {
        this.windows.forEach(w => {
            w.style.zIndex = '1';
        });
        window.style.zIndex = '100';
        this.activeWindow = window;
        
        const title = window.querySelector('.window-title-text').textContent;
        document.getElementById('active-title').textContent = title;
    }

    initializeTerminal(window) {
        const output = window.querySelector('.terminal-output');
        const input = window.querySelector('.terminal-input');
        
        this.addTerminalLine(output, 'AVIOS Terminal v1.0.0');
        this.addTerminalLine(output, 'Type "help" for available commands');
        this.addTerminalLine(output, '');
        
        input.addEventListener('keydown', (e) => {
            if (e.key === 'Enter') {
                const command = input.value.trim();
                if (command) {
                    this.addTerminalLine(output, `root@avios:~# ${command}`);
                    this.executeCommand(command, output);
                    input.value = '';
                }
            }
        });
        
        input.focus();
    }

    addTerminalLine(output, text, className = '') {
        const line = document.createElement('div');
        line.className = `terminal-line ${className}`;
        line.textContent = text;
        output.appendChild(line);
        output.scrollTop = output.scrollHeight;
    }

    executeCommand(command, output) {
        const parts = command.split(' ');
        const cmd = parts[0].toLowerCase();
        
        const responses = {
            'help': `Available commands:
  help       - Show this help message
  clear      - Clear terminal
  neofetch   - System information
  ls         - List directory contents
  nmap       - Network scanner
  whoami     - Print current user
  uname      - System information
  date       - Show current date/time
  ifconfig   - Network configuration
  ps         - Process status`,
            
            'clear': () => { output.innerHTML = ''; return null; },
            
            'whoami': 'root',
            
            'neofetch': `        _    __     ______  _____ 
       / \\  \\ \\   / /_ _| |  _  |
      / _ \\  \\ \\ / / | | | | | | |
     / ___ \\  \\ V /  | | | |_| |
    /_/   \\_\\  \\_/  |___| |_____|
    
    OS: AVIOS v1.0.0
    Kernel: Linux 5.15.0-avios
    Shell: bash 5.1.0
    CPU: Intel Core i7 (4) @ 3.5GHz
    Memory: 512MB / 2048MB
    Network: Active`,
            
            'uname': 'Linux avios 5.15.0-avios #1 SMP x86_64 GNU/Linux',
            
            'date': new Date().toString(),
            
            'ls': 'Desktop  Documents  Downloads  Pictures  Videos  Tools',
            
            'ifconfig': `eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.100  netmask 255.255.255.0  broadcast 192.168.1.255
        ether 08:00:27:ab:cd:ef  txqueuelen 1000  (Ethernet)`,
            
            'ps': `  PID TTY          TIME CMD
    1 ?        00:00:01 systemd
  432 ?        00:00:00 avios-desktop
  891 pts/0    00:00:00 bash`,
            
            'nmap': 'Nmap 7.92 ( https://nmap.org )\nUsage: nmap [Scan Type(s)] [Options] {target specification}',
            
            'default': `Command not found: ${cmd}\nType 'help' for available commands`
        };
        
        const response = responses[cmd] || responses['default'];
        
        if (typeof response === 'function') {
            const result = response();
            if (result) this.addTerminalLine(output, result);
        } else {
            response.split('\n').forEach(line => {
                this.addTerminalLine(output, line);
            });
        }
    }
}

// Initialize AVIOS Desktop when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    window.avios = new AVIOSDesktop();
});
