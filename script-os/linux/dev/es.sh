#!/bin/bash

APP_PROG=es
APP_HOME="/opt/$APP_PROG"
APP_NODE=$(hostname)

APP_PID="$APP_HOME/$APP_PROG.pid"

APP_DATA="/data/$APP_PROG"

function set_process() {
  NODE_NAME=$1
  PID_FILE=$2

  if [ $? -eq 0 ];
  then
    echo -n "$APP_PROG: $NODE_NAME ... "
    sleep 5

    if [ -f "$PID_FILE" ];
    then
      echo "STARTED"
    else
      echo "failed to write to $PID_FILE"
      exit 1
    fi

  else
    echo "$APP_PROG is not running..."
    exit 1
  fi
}

function start_process() {
  NODE_NAME=$1
  PID_FILE=$2

  $APP_HOME/bin/elasticsearch -d -p $PID_FILE
  set_process $NODE_NAME $PID_FILE
}

function stop_process() {
  NODE_NAME=$1
  PID_FILE=$2

  echo -n "$APP_PROG: $NODE_NAME ... "
  if [ ! -f "$PID_FILE" ];
  then
    echo "no $APP_PROG to stop (could not find file $PID_FILE)"
  else
    kill $(cat "$PID_FILE")
    sleep 1
    echo "STOPPED"

    if [ -f "$PID_FILE" ];
    then
      /bin/rm "$PID_FILE"
    fi
  fi
}

function check_process() {
  NODE_NAME=$1
  PID_FILE=$2

  echo -n "$APP_PROG: $NODE_NAME ... "
  if [ ! -f "$PID_FILE" ];
  then
    echo "NOT RUNNING"
  else
    echo "RUNNING"
  fi
}

case "$1" in
  'start')
    start_process $APP_NODE $APP_PID
    ;;

  'stop')
    stop_process $APP_NODE $APP_PID
    ;;

  'status')
    check_process $APP_NODE $APP_PID
    ;;

  *)
    echo "Usage: $0 { start | stop | status }"

esac
exit 0