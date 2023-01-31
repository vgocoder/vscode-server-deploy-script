#!/bin/sh
vscodeCliBinFile="vscode_cli_alpine_x64_cli.tar.gz"
vscodeCliFile="code-insiders"
vscodeCliPath="/usr/bin"
vscodeLogFile="vscode-server.log"
tunnelName=$1

# tunnel name

if [ -z "$1" ]; then
    tunnelName="tunnel-`cat /proc/sys/kernel/random/uuid  | md5sum |cut -c 1-8`"
    echo $tunnelName
fi

# pid
PIDS=`ps -ef | grep "{$vscodeCliFile} tunnel" | grep -v grep | awk '{print $2}'`
for pid in $PIDS
do
  kill -9 $pid
done

# vscode-server bin file
if [ ! -f "$vscodeCliBinFile" ]; then
    echo "$vscodeCliBinFile not found!"
    exit 0
fi 

# unzip
if [ ! -f "$vscodeCliPath/$vscodeCliFile" ]; then
    sudo tar zxf $vscodeCliBinFile -C $vscodeCliPath
    sudo chmod +x $vscodeCliPath/$vscodeCliFile
fi 

# start tunnel
nohup $vscodeCliPath/$vscodeCliFile tunnel --name $tunnelName --accept-server-license-terms > $vscodeLogFile 2>&1 &

# logs tail
tail -f $vscodeLogFile
