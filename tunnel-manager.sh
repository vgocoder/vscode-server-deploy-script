#!/bin/sh
vscodeCliBinFile="vscode_cli_alpine_x64_cli.tar.gz"
vscodeCliFile="code"
vscodeCliPath="/usr/bin"
vscodeLogFile="vscode-server.log"
downloadUrl="https://update.code.visualstudio.com/latest/cli-alpine-x64/stable"
action=$1
tunnelName=$2

# functions
log() {
    logfile=$vscodeLogFile
    timestamp=$(date +"%Y-%m-%d %T")
    echo "$timestamp: $1" >>$logfile
}

killProcessByName() {
    processName=$1
    pids=$(ps -ef | grep $processName | grep -v grep | awk '{print $2}')
    for pid in $pids; do
        kill -9 $pid
        log "Process $processName with PID $pid was killed."
    done
    if [ -z "$pids" ]; then
        log "No instances of process $processName were found."
    fi
}

downloadLatestVersion() {
    log "Downloading latest version from $downloadUrl"
    if command -v curl >/dev/null 2>&1; then
        curl -L $downloadUrl -o $vscodeCliBinFile
    elif command -v wget >/dev/null 2>&1; then
        wget -O $vscodeCliBinFile $downloadUrl
    else
        log "Neither curl nor wget is installed. Please install one of them."
        exit 1
    fi

    if [ $? -ne 0 ]; then
        log "Download failed"
        exit 1
    fi
    log "Download completed successfully"
}

startTunnel() {
    local tunnelName=$1
    # check and download latest version
    if [ ! -f "$vscodeCliBinFile" ] || [ -n "$3" ] && [ "$3" = "--update" ]; then
        downloadLatestVersion
    fi

    # verify downloaded file exists
    if [ ! -f "$vscodeCliBinFile" ]; then
        log "$vscodeCliBinFile not found, exit now"
        exit 1
    fi

    # extract binary
    if [ ! -f "$vscodeCliPath/$vscodeCliFile" ] || [ -n "$3" ] && [ "$3" = "--update" ]; then
        log "Extracting $vscodeCliBinFile to $vscodeCliPath"
        sudo tar zxf $vscodeCliBinFile -C $vscodeCliPath
        if [ $? -ne 0 ]; then
            log "Extraction failed"
            exit 1
        fi
        sudo chmod +x $vscodeCliPath/$vscodeCliFile
        log "Extraction completed successfully"
    fi

    # check tunnel name
    if [ -z "$tunnelName" ]; then
        tunnelName="tunnel-$(cat /proc/sys/kernel/random/uuid | md5sum | cut -c 1-8)"
        log "Tunnel name not specified, using random name: $tunnelName"
    fi

    # start tunnel
    log "Starting tunnel with name: $tunnelName"
    nohup $vscodeCliPath/$vscodeCliFile tunnel --name $tunnelName --accept-server-license-terms 2>&1 | while read line; do log "$line"; done &
    log "Tunnel service started"
}

stopTunnel() {
    log "Stopping VS Code tunnel service"
    killProcessByName $vscodeCliFile
    log "VS Code tunnel service stopped"
}

showUsage() {
    echo "Usage:"
    echo "  $0 start [tunnel-name] [--update]  - Start tunnel service with optional name and update flag"
    echo "  $0 stop                            - Stop tunnel service"
    echo "Examples:"
    echo "  $0 start                           - Start with random tunnel name"
    echo "  $0 start my-tunnel                 - Start with specific tunnel name"
    echo "  $0 start my-tunnel --update        - Start with specific name and force update"
    echo "  $0 stop                            - Stop all running tunnels"
}

# Main logic
case "$action" in
"start")
    startTunnel "$tunnelName" "$3"
    ;;
"stop")
    stopTunnel
    ;;
*)
    showUsage
    exit 1
    ;;
esac
