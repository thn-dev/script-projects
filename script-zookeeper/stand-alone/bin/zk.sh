#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/setenv.sh

function execute_zk()
{
    CMD=$1
    
    for i in {1..3}
    do
        echo ""
        ZK_HOME=$APP_HOME/zks$i
        $ZK_HOME/bin/zkServer.sh $CMD &
        sleep 2
    done
}

case "$1" in
    'start.all')
        execute_zk start
        ;;

    'stop.all')
        execute_zk stop 
        ;;

    'status.all')
        execute_zk status 
        ;;
        
    *)
        echo "Usage: $0 {start.all | stop.all | status.all}"

esac
exit 0