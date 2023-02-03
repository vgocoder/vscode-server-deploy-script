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
  echo "$timestamp: $1" >> $logfile
}

# tunnel name

if [ -z "$1" ]; then
    tunnelName="tunnel-`cat /proc/sys/kernel/random/uuid  | md5sum |cut -c 1-8`"
    log "tunnel name not specified,just specify a name at random:$tunnelName "
fi

# pid
PIDS=`ps -ef | grep "{$vscodeCliFile}" | grep -v grep | awk '{print $2}'`
for pid in $PIDS
do
  kill -9 $pid
  log "$pid killed"
done

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

# start tunnel
nohup $vscodeCliPath/$vscodeCliFile tunnel prune 2>&1 | while read line; do log "$line" >> $vscodeLogFile; done &
nohup $vscodeCliPath/$vscodeCliFile tunnel --name $tunnelName --accept-server-license-terms 2>&1 | while read line; do log "$line" >> $vscodeLogFile; done &

# logs tail
tail -f $vscodeLogFile