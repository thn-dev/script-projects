#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/yarn-env.sh

HOST_NAME="$1"

echo -e "copy file to $USER_NAME@$HOSTNAME"
ssh-copy-id -i $HOME/.ssh/id_rsa.pub $USER_NAME@$HOST_NAME
