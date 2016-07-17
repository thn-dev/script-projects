#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/setenv.sh

while read line
do
  HOST_NAME=line
  echo "copy file to $USER_NAME@$HOSTNAME"
  ssh-copy-id -i $HOME/.ssh/id_rsa.pub $USER_NAME@$HOST_NAME
done < $1
