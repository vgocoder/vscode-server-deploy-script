# Visual Studio Code Server Deploy Script Using the 'code' CLI

## Developing with Visual Studio Code Remote Tunnels 

> You may create a secure tunnel through the 'code' CLI with this script quickly

### Remote Usage

- Use the Script
```
git clone https://github.com/vgocoder/vscode-server-deploy-script.git
cd vscode-server-deploy-script
./run-vscode-server.sh your-tunnel-name
```

- Authenticate
    > You'll be provided a device code and URL to authenticate your GitHub account into the secure tunneling service.

    - First time launching the VS Code Server on this remote machine use the script
    ```
    ~/vscode-server-deploy-script$ ./run-vscode-server.sh your-tunnel-name

    *
    * Visual Studio Code Server
    *
    * By using the software, you agree to
    * the Visual Studio Code Server License Terms (https://aka.ms/vscode-server-license) and
    * the Microsoft Privacy Statement (https://privacy.microsoft.com/en-US/privacystatement).
    *
    To grant access to the server, please log into https://github.com/login/device and use code XXXX-XXXX
    [2023-01-31 22:24:41] info Creating tunnel with the name: your-tunnel-name

    Open this link in your browser https://insiders.vscode.dev/tunnel/your-tunnel-name/home/ubuntu/vscode-server-deploy-script
    ```

    - After authenticating 
    ```
    ~/vscode-server-deploy-script$ ./run-vscode-server.sh your-tunnel-name

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

### Client Usage

After authenticating and providing a machine name, you then have a couple options for connecting to your remote machine:

- Select the vscode.dev link the CLI prints that's connected to your server instance.
- Open vscode.dev or a desktop instance of VS Code directly, and run the command: Remote - Tunnels: Connect to remote... (you may use F1 to open the Command Palette to find this command).