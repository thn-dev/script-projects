#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/spark-env.sh

case "$1" in
  'start')
    $SPARK_HOME/sbin/start-all.sh
    ;;

  'stop')
    $SPARK_HOME/sbin/stop-all.sh
    ;;

  *)
    echo "Usage: $0 {start | stop}"

esac
exit 0
