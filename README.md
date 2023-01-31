# Visual Studio Code Server Deploy Script

## Developing with Visual Studio Code Remote Tunnels 

You may create a secure tunnel through the code CLI with this script quickly

### Use:
```
./run-vscode-server.sh your-tunnel-name
```

#### *1. Manual authorization for the first time*

```
~/vscode-server$ ./run-vscode-server.sh your-tunnel-name

*
* Visual Studio Code Server
*
* By using the software, you agree to
* the Visual Studio Code Server License Terms (https://aka.ms/vscode-server-license) and
* the Microsoft Privacy Statement (https://privacy.microsoft.com/en-US/privacystatement).
*
To grant access to the server, please log into https://github.com/login/device and use code XXXX-XXXX
[2023-01-31 22:24:41] info Creating tunnel with the name: your-tunnel-name

Open this link in your browser https://insiders.vscode.dev/tunnel/your-tunnel-name/home/ubuntu/vscode-server
```

#### 2. Authorized 
```
~/vscode-server$ ./run-vscode-server.sh your-tunnel-name

*
* Visual Studio Code Server
*
* By using the software, you agree to
* the Visual Studio Code Server License Terms (https://aka.ms/vscode-server-license) and
* the Microsoft Privacy Statement (https://privacy.microsoft.com/en-US/privacystatement).
*
[2023-01-31 22:55:53] info Creating tunnel with the name: your-tunnel-name

Open this link in your browser https://insiders.vscode.dev/tunnel/your-tunnel-name/home/ubuntu/vscode-server
```