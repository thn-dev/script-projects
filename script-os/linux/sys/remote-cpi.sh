#!/bin/bash

function copy_ex() {
  HOSTS="$1"
  PEM_FILE="$2"
  USER_NAME="$3"
  LOCAL_PATH="$4"
  REMOTE_PATH="$5"

  echo "$PEM_FILE"

  while read line
  do
    SERVER_NAME="$line"
    echo ""
    echo "copy $LOCAL_PATH to $USER_NAME@$SERVER_NAME:$REMOTE_PATH"
    scp -i "$PEM_FILE" "$LOCAL_PATH" $USER_NAME@$SERVER_NAME:"$REMOTE_PATH"
  done < $HOSTS
}

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ] || [ -z "$5" ]; then
  echo "Usage: $0 host-file pem-file user-name local-path remote-path"
else
  copy_ex "$1" "$2" "$3" "$4" "$5"
fi

exit 0
