#!/bin/bash

. ./setenv.sh

case "$1" in
  'start')
    $CATALINA_HOME/bin/startup.sh &
    ;;

  'stop')
    $CATALINA_HOME/bin/shutdown.sh &
    ;;

  *)
    echo "Usage: $0 {start | stop}"

esac
exit 0
