#!/bin/bash

case "$1" in
  "top")
    xxd -l $2 $3
    ;;
  "bottom")
    xxd -s $2 $3
    ;;

  "from")
    xxd -s $2 $3
    ;;

  *)
    echo "Usage: $0 {top | bottom | from} length file-name"

esac
exit 0
