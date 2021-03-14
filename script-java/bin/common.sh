#!/bin/bash

start() {
  $START_COMMAND &
  PID=`echo $!`
}

case "$1" in
  start)
    if [ -f $PID_FILE ]; then
      PID=`cat $PID_FILE`
      if [ -z "`ps -ef | grep ${PID} | grep -v grep`" ]; then
        start
      else
        echo "${SERVICE_NAME} is running [${PID}]"
        exit 0
      fi
    else
      start
    fi

    if [ -z $PID ]; then
      echo "Cannot start ${SERVICE_NAME}"
      exit 1
    else
      echo $PID > $PID_FILE
      echo "${SERVICE_NAME} is started [${PID}]"
      exit 0
    fi
  ;;

  stop)
    if [ -f $PID_FILE ]; then
      PID=`cat $PID_FILE`
      if [ -z "`ps -ef | grep ${PID} | grep -v grep`" ]; then
        echo "${SERVICE_NAME} is not running [${PID}]"
        rm -f $PID_FILE
        exit 1
      else
        kill -term $PID
        echo "${SERVICE_NAME} is stopped [${PID}]"
        rm -f $PID_FILE
        exit 0
      fi
    else
      echo "${SERVICE_NAME} is not running (pid not found)"
      exit 0
    fi
  ;;

  status)
    if [ -f $PID_FILE ]; then
      PID=`cat $PID_FILE`
      if [ -z "`ps -ef | grep ${PID} | grep -v grep`" ]; then
        echo "${SERVICE_NAME} is not running [${PID}]"
        exit 1
      else
        echo "${SERVICE_NAME} is running [${PID}]"
        exit 0
      fi
    else
      echo "${SERVICE_NAME} is not running"
      exit 0
    fi
  ;;

  restart)
    $0 stop
    $0 start
  ;;

  *)
    echo "Usage: $0 { start | stop | status | restart }"
    exit 0

esac