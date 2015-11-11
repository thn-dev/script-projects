#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/setenv.sh

HADOOP_PREFIX=$APP_HOME/hadoop/
export HADOOP_PREFIX

case "$1" in
    'start')
        $HADOOP_PREFIX/bin/start-all.sh
        ;;

    'stop')
        $HADOOP_PREFIX/bin/stop-all.sh
        ;;

    *)
        echo "Usage: $0 {start | stop}"
esac
exit 0

