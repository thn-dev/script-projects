#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/setenv.sh

function remote_ex()
{
    HOSTS=$1
    REMOTE_CMD=$2
    
    while read line
    do
        HOST_NAME=$line
        echo ""
        echo "connecting to $USER_NAME@$HOST_NAME"
        ssh -n $USER_NAME@$$HOST_NAME "$REMOTE_CMD"
    done < $HOSTS
}

# ------------------------------------------------------------------------------
# Usage: $0 <list-of-hosts> <remote-command>
# where
#   - list-of-hosts is a text file containing a list of hosts, one per line
#   - remote-command is the command to be executed at each remote host
# ------------------------------------------------------------------------------
remote_ex "$1" "$2"
