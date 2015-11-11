#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/setenv.sh

SOLR_ZK="-DzkHost=$(hostname):2181,$(hostname):2182,$(hostname):2183"
SOLR_HOST="-Dhost=$(hostname)"
SOLR_SHARDS="-DnumShards=3"
SOLR_MEM="-Xms256m -Xmx512m"
SOLR_COLLECTION=indexcloud

function set_process()
{
    if [ $? -eq 0 ]
    then
        echo -n "starting $1 ... "
        if /bin/echo -n $! > $1
        then
            sleep 1
            echo "STARTED"
        else
            echo "failed to write pid to $1..."
            exit 1
        fi
    else
        echo "solr is not running..."
        exit 1
    fi
}

function stop_process()
{
    SOLR_NAME=$1
    SOLR_DATA=$APP_DATA/$SOLR_NAME
    SOLR_PID=$SOLR_DATA/$SOLR_NAME.pid

    echo -n "stopping $SOLR_PID ... "
    if [ ! -f "$SOLR_PID" ]
    then
        echo "no solr to stop (could not find file $SOLR_PID)"
    else
        kill $(cat "$SOLR_PID")
        sleep 1
        rm "$SOLR_PID"
        echo "STOPPED"
    fi
}

function start_process()
{
    SOLR_NAME=$1
    PORT=$2

    SOLR_HOME=$APP_HOME/$SOLR_NAME
    SOLR_DATA=$APP_DATA/$SOLR_NAME
    SOLR_PID=$SOLR_DATA/$SOLR_NAME.pid

    SOLR_CFG="-Dsolr.solr.home=$SOLR_DATA -Djetty.port=$PORT"

    if [ $3 ];
    then
        if [ $3 == 'reg' ];
        then
            SOLR_CFG="$SOLR_CFG -Dbootstrap_confdir=$SOLR_DATA/$SOLR_COLLECTION/conf -Dcollection.configName=cfgIndexCloud"
        fi
    fi

    SOLR_OPTS="$SOLR_MEM $SOLR_HOST $SOLR_ZK $SOLR_CFG $SOLR_SHARDS"

    cd $SOLR_HOME
    nohup java $SOLR_OPTS -jar start.jar > /dev/null 2>&1 &
    set_process $SOLR_PID
}

function clear_index()
{
    SOLR_NAME=$1
    SOLR_DATA=$APP_DATA/$SOLR_NAME
    echo -n "removing $SOLR_DATA data ... "

    rm -rf $SOLR_DATA/$SOLR_COLLECTION/data
    echo "DONE"
    sleep 1
}

case "$1" in
    'start.all')
        start_process solr01 8983
        start_process solr02 8984
        start_process solr03 7574
        ;;

    'stop.all')
        stop_process solr01
        stop_process solr02
        stop_process solr03
        ;;


    'clear.index')
        clear_index solr01
        clear_index solr02
        clear_index solr03
        ;;

    'master')
        case "$2" in
            'start')
                start_process solr01 8983 reg
                ;;

            'stop')
                stop_process solr01
                ;;
        esac
        ;;

    *)
        echo "Usage: $0 {start.all | stop.all | clear.index}"

esac
exit 0
