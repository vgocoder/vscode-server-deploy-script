# VS Code Remote Tunnel Manager

A shell script to manage VS Code remote tunnels for secure remote development. This tool provides an easy way to deploy, start, stop, and manage VS Code tunnels with automatic CLI installation and updates.

## Features

- Quick tunnel creation with custom or random names
- Automatic download and installation of the latest VS Code CLI
- Secure authentication through GitHub
- Process management (start/stop)
- Detailed logging system
- Support for both curl and wget
- Force update capability
- Simple deployment process

## Prerequisites

- Linux/Unix-based operating system
- sudo privileges
- Either curl or wget installed
- Internet connection
- GitHub account for authentication

## Installation

1. Clone the repository:
```bash
git clone https://github.com/vgocoder/vscode-server-deploy-script.git
cd vscode-server-deploy-script
```

2. Make the script executable:
```bash
chmod +x tunnel-manager.sh
```

## Usage

### Starting a Tunnel

With custom name:
```bash
./tunnel-manager.sh start your-tunnel-name
```

With random name:
```bash
./tunnel-manager.sh start
```

Force update and start:
```bash
./tunnel-manager.sh start your-tunnel-name --update
```

### Stopping Tunnels
```bash
./tunnel-manager.sh stop
```

### Authentication Process

1. First-time Launch:
   - Run the script with your desired tunnel name
   - You'll receive a device code and GitHub authentication URL
   - Visit https://github.com/login/device and enter the code
   - Example output:
```
* Visual Studio Code Server
*
* By using the software, you agree to
* the Visual Studio Code Server License Terms (https://aka.ms/vscode-server-license) and
* the Microsoft Privacy Statement (https://privacy.microsoft.com/en-US/privacystatement).
*
To grant access to the server, please log into https://github.com/login/device and use code XXXX-XXXX
```

2. Subsequent Launches:
   - The script will automatically create the tunnel
   - You'll receive a direct VS Code connection link

### Client Connection Methods

After authentication, connect to your remote machine using either:
1. Click the vscode.dev link provided in the CLI output
2. Use VS Code desktop or vscode.dev:
   - Press F1 to open Command Palette
   - Run "Remote - Tunnels: Connect to remote..."
   - Select your tunnel name

## Configuration

Default settings (customizable in the script):
```bash
vscodeCliBinFile="vscode_cli_alpine_x64_cli.tar.gz"
vscodeCliFile="code"
vscodeCliPath="/usr/bin"
vscodeLogFile="vscode-server.log"
```

## Logging

All operations are logged to `vscode-server.log`, including:
- Authentication events
- Tunnel status changes
- Installation progress
- Error messages

## Troubleshooting

### Common Issues

1. Permission denied
```bash
sudo chmod +x tunnel-manager.sh
```

2. Download fails
- Check internet connection
- Verify download URL
- Ensure curl/wget is installed

3. Authentication fails
- Verify GitHub account access
- Check the device code validity
- Ensure stable internet connection

## Contributing

Contributions are welcome! Please feel free to submit Pull Requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter issues:
1. Check the troubleshooting section
2. Review the log file
3. Open an issue in the repository

## Changelog

### v0.1.0 (2025-01-16)
- Added start/stop functionality
- Implemented auto-download and installation
- Added logging system
- Improved authentication handling
- Added force update option
```