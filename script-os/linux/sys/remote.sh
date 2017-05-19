#!/bin/bash

function remote_ex() {
  HOSTS=$2
  USER_NAME=$3
  REMOTE_CMD=$4

  case "$1" in
    "-s")
      # execute command at a given host

      SERVER_NAME=$HOSTS
      echo ""
      echo "connecting to $USER_NAME@$SERVER_NAME"
      ssh -n $USER_NAME@$SERVER_NAME "$REMOTE_CMD"
      ;;

    "-m")
      # execute command at a given list of hosts

      while read line
      do
        SERVER_NAME=$line
        echo ""
        echo "connecting to $USER_NAME@$SERVER_NAME"
        ssh -n $USER_NAME@$SERVER_NAME "$REMOTE_CMD"
      done < $HOSTS
      ;;

    *)
      echo ""
      echo "Execute given command at remote host(s)"
      echo "- at single remote host"
      echo "  $0 -s host-name user-name command"
      echo ""
      echo "- at a list of remote hosts"
      echo "  $0 -m host-file user-name command"
      echo ""
  esac
  exit 0
}

remote_ex "$1" "$2" "$3" "$4"
