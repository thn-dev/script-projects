#!/bin/bash

function remote_ex() {
  HOSTS="$1"
  PEM_FILE="$2"
  USER_NAME="$3"
  REMOTE_CMD="$4"

  while read line
  do
    HOST_NAME=$line
    echo ""
    echo "connecting to $USER_NAME@$HOST_NAME"
    ssh -i $PEM_FILE -n -tt $USER_NAME@$HOST_NAME "$REMOTE_CMD"
  done < $HOSTS
}

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
  echo "Usage: $0 host-file pem-file user-name remote-cmd"
else
  remote_ex "$1" "$2" "$3" "$4"
fi

exit 0

