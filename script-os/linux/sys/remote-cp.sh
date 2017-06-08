#!/bin/bash

function remote_cp() {
  case "$1" in
    "-s")
      # execute command at a given host
      USER_NAME="$2"
      HOST_NAME="$3"
      LOCAL_PATH="$4"
      REMOTE_PATH="$5"

      echo -e "\n\033[0;32m[$]$\033[0m \033[0;36mscp \"$LOCAL_PATH $USER_NAME@$HOST_NAME:$REMOTE_PATH\"\033[0m"
      scp "$LOCAL_PATH $USER_NAME@$HOST_NAME:$REMOTE_PATH"
      ;;

    "-m")
      # execute command at a given list of hosts
      USER_NAME="$2"
      HOST_FILE="$3"
      LOCAL_PATH="$4"
      REMOTE_PATH="$5"

      while read line
      do
        HOST_NAME=$line
        echo -e "\n\033[0;32m[$]$\033[0m \033[0;36mcop \"$LOCAL_PATH\" to \"$USER_NAME@$HOST_NAME:$REMOTE_PATH\"\033[0m"
        scp "$LOCAL_PATH $USER_NAME@$HOST_NAME:$REMOTE_PATH"
      done < $HOST_FILE
      ;;

    *)
      echo ""
      echo "Execute given command at remote host(s)"
      echo "- at a single remote host"
      echo "  $0 -s user-name host-name local-path remote-path"
      echo ""
      echo "- at a list of remote hosts"
      echo "  $0 -m user-name host-file local-path remote-path"
      echo ""
  esac
  exit 0
}

remote_cp "$1" "$2" "$3" "$4" "$5"
