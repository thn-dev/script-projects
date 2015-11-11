#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/setenv.sh

function execute_zk()
{
    CMD=$1
    
    echo ""
    ZK_HOME=$APP_HOME/zookeeper
    $ZK_HOME/bin/zkServer.sh $CMD &
    sleep 2
}

case "$1" in
    'start')
        execute_zk start 
        ;;

    'stop')
        execute_zk stop 
        ;;

    'status')
        execute_zk status 
        ;;
        
    *)
        echo "Usage: $0 {start | stop | status}"

esac
exit 0