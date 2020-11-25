#!/bin/bash

case "$1" in
  "current")
    CURRENT_DATE=`date '+%Y-%m-%d'`
    echo "current date: $CURRENT_DATE"
    ;;

  "current.dt")
    CURRENT_DATETIME=`date '+%Y-%m-%d %H:%M:%S'`
    echo "current date/time: $CURRENT_DATETIME"
    ;;

  "previous")
    DAYS=1
    if [ ! -z $2 ]; then
      DAYS=$2
    fi

    CURRENT_DATE=`date '+%Y-%m-%d'`
    PREVIOUS_DATE=`date -v -"$DAYS"d +%Y-%m-%d`
    echo "previous date: $PREVIOUS_DATE"
    ;;

  "next")
    NEXT_DATE=`date +%Y-%m-%d`
    echo "next date: $NEXT_DATE"
    ;;

  *)
    echo "Usage: $0 {current | current.dt | previous | next}"

esac
exit 0
