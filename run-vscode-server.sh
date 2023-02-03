#!/bin/sh
vscodeCliBinFile="vscode_cli_alpine_x64_cli.tar.gz"
vscodeCliFile="code-insiders"
vscodeCliPath="/usr/bin"
vscodeLogFile="vscode-server.log"
tunnelName=$1

# functions

log() {
    logfile=$vscodeLogFile
    timestamp=$(date +"%Y-%m-%d %T")
    echo "$timestamp: $1" >>$logfile
}

killProcessByName() {
    processName=$1
    # Find all process IDs using ps and grep
    pids=$(ps -ef | grep $processName | grep -v grep | awk '{print $2}')
    # Loop through all process IDs
    for pid in $pids; do
        # Kill the process using the PID
        kill -9 $pid
        log "Process $processName with PID $pid was killed."
    done
    # If no process was found
    if [ -z "$pids" ]; then
        log "No instances of process $processName were found."
    fi
}

# kill process
killProcessByName $vscodeCliFile

# vscode-server bin file
if [ ! -f "$vscodeCliBinFile" ]; then
    log "$vscodeCliBinFile not found,exit now"
    exit 0
fi

# unzip
if [ ! -f "$vscodeCliPath/$vscodeCliFile" ]; then
    sudo tar zxf $vscodeCliBinFile -C $vscodeCliPath
    sudo chmod +x $vscodeCliPath/$vscodeCliFile
fi

# prune tunnel
# nohup $vscodeCliPath/$vscodeCliFile tunnel prune 2>&1 | while read line; do log "$line" >>$vscodeLogFile; done &

# check tunnel name
if [ -z "$1" ]; then
    tunnelName="tunnel-$(cat /proc/sys/kernel/random/uuid | md5sum | cut -c 1-8)"
    log "tunnel name not specified,just specify a name at random:$tunnelName "
fi

# start tunnel
nohup $vscodeCliPath/$vscodeCliFile tunnel --name $tunnelName --accept-server-license-terms 2>&1 | while read line; do log "$line" >>$vscodeLogFile; done &

# logs tail
tail -f $vscodeLogFile
