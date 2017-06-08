#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/yarn-env.sh

HADOOP_YARN_HOME=$HADOOP_PREFIX
export HADOOP_YARN_HOME

HADOOP_CONF_DIR=$HADOOP_PREFIX/etc/hadoop
export HADOOP_CONF_DIR

YARN_CONF_DIR=$HADOOP_CONF_DIR
export YARN_CONF_DIR

case "$1" in
  "start")
    $HADOOP_PREFIX/sbin/start-dfs.sh
    $HADOOP_PREFIX/sbin/start-yarn.sh
    $HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh --config $HADOOP_CONF_DIR start historyserver
    ;;

  "stop")
    $HADOOP_PREFIX/sbin/stop-yarn.sh
    $HADOOP_PREFIX/sbin/stop-dfs.sh
    $HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh --config $HADOOP_CONF_DIR stop historyserver
    ;;

  "reset")
    rm -rf $HADOOP_DATA/dfs/{nn,dn,sn}/*
    rm -rf $HADOOP_DATA/{local,logs,pids}/*
    rm -rf $HADOOP_DATA/mapred/{local,temp,system}/*
    ;;

  *)
    echo "Usage: $0 {start | stop | reset}"
esac
exit 0
