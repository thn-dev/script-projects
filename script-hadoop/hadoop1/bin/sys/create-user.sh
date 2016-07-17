
#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/../setenv.sh

# create group name and user name
groupadd $GROUP_NAME
useradd -g $GROUP_NAME $USER_NAME
passwd $USER_NAME

# create bin directory in user's home
mkdir -p $USER_HOME/bin
chown -R $USER_NAME:$GROUP_NAME $USER_HOME/bin
