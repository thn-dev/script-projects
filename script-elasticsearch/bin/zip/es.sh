#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/../@es.setenv-file@

ES_HOME="@es.home@"

# pid file
ES_PID="@es.path-pid@/@es.prog@.pid"

# heap size
ES_HEAP_SIZE=@es.heap-size@
export ES_HEAP_SIZE

# cluster name
ES_CNAME=@es.cluster-name@
ES_NODE=$(hostname)

function start_process()
{
    NODE_NAME=$1
    PID_FILE=$2
    CLUSTER_NAME=$3

    echo -n "starting es.node: $NODE_NAME ... "
    $ES_HOME/bin/elasticsearch -d -p $PID_FILE --cluster.name $CLUSTER_NAME --node.name $NODE_NAME
    sleep 1
    echo "DONE"
}

function stop_process()
{
    NODE_NAME=$1
    PID_FILE=$2

    echo -n "stopping es.node: $NODE_NAME ... "
    if [ ! -f "$PID_FILE" ]
    then
        echo "no elasticsearch to stop (could not find file $PID_FILE)"
    else
        kill $(cat "$PID_FILE")
        sleep 1
        echo "DONE"
    fi
}

function check_process()
{
    NODE_NAME=$1
    PID_FILE=$2

    echo -n "checking es.node: $NODE_NAME ... "
    if [ ! -f "$PID_FILE" ]
    then
        echo "NOT RUNNING"
    else
        echo "RUNNING"
    fi

}

case "$1" in
    'start')
        start_process $ES_NODE $ES_PID $ES_CNAME
        ;;

    'stop')
        stop_process $ES_NODE $ES_PID
        ;;

    'status')
        check_process $ES_NODE $ES_PID
        ;;

    *)
        echo "Usage: $0 {start | stop | status}"

esac
exit 0

