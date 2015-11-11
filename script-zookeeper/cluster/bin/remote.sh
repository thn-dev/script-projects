#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/hdenv.sh

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

remote_ex "$1" "$2"