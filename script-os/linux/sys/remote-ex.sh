#!/bin/bash

function remote_ex() {
  case "$1" in
    "-s")
      # execute command at a given host
      USER_NAME="$2"
      HOST_NAME="$3"
      REMOTE_CMD="$4"

      echo -e "\n\033[0;32m[$USER_NAME@$HOST_NAME]$\033[0m \033[0;36m$REMOTE_CMD\033[0m"
      ssh -n -tt $USER_NAME@$HOST_NAME "$REMOTE_CMD"
      ;;

    "-m")
      # execute command at a given list of hosts
      USER_NAME="$2"
      HOST_FILE="$3"
      REMOTE_CMD="$4"

      while read line
      do
        HOST_NAME=$line
        echo -e "\n\033[0;32m[$USER_NAME@$HOST_NAME]$\033[0m \033[0;36m$REMOTE_CMD\033[0m"
        ssh -n -tt $USER_NAME@$HOST_NAME "$REMOTE_CMD"
      done < $HOST_FILE
      ;;

    *)
      echo ""
      echo "Execute given command at remote host(s)"
      echo "- at a single remote host"
      echo "  $0 -s user-name host-name command"
      echo ""
      echo "- at a list of remote hosts"
      echo "  $0 -m user-name host-file command"
      echo ""
  esac
  exit 0
}

remote_ex "$1" "$2" "$3" "$4"
