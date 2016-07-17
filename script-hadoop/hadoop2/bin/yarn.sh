#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/setenv.sh

HADOOP_PREFIX=$APP_HOME/yarn
export HADOOP_PREFIX

HADOOP_YARN_HOME=$HADOOP_PREFIX
export HADOOP_YARN_HOME

HADOOP_CONF_DIR=$HADOOP_PREFIX/etc/hadoop
export HADOOP_CONF_DIR

YARN_CONF_DIR=$HADOOP_CONF_DIR
export YARN_CONF_DIR

HADOOP_PID_DIR=$APP_DATA/yarn/pids
export HADOOP_PID_DIR

YARN_PID_DIR=$HADOOP_PID_DIR
export YARN_PID_DIR

HADOOP_LOG_DIR=$APP_DATA/yarn/logs
export HADOOP_LOG_DIR

YARN_LOG_DIR=$HADOOP_LOG_DIR
export YARN_LOG_DIR

#YARN_RESOURCEMANAGER_HEAPSIZE
#YARN_NODEMANAGER_HEAPSIZE
#HADOOP_JOB_HISTORYSERVER_HEAPSIZE

case "$1" in
    'start')
        $HADOOP_PREFIX/sbin/start-dfs.sh
        $HADOOP_PREFIX/sbin/start-yarn.sh
        $HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh --config $HADOOP_CONF_DIR start historyserver
        ;;

    'stop')
        $HADOOP_PREFIX/sbin/stop-yarn.sh
        $HADOOP_PREFIX/sbin/stop-dfs.sh
        $HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh --config $HADOOP_CONF_DIR stop historyserver
        ;;

    *)
        echo "Usage: $0 {start | stop}"
esac
exit 0

