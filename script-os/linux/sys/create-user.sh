
#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/../yarn-env.sh

function update_user() {
  # create bin directory in user's home directory
  USER_BIN=$USER_HOME/bin
  if [ ! -d "$USER_BIN" ]; then
    mkdir -p $USER_BIN
  fi

  chown -R $USER_NAME:$GROUP_NAME $USER_BIN
}

# create group name
groupadd $GROUP_NAME

case "$1" in
  "add")
    # create a new user name
    useradd -g $GROUP_NAME $USER_NAME
    passwd $USER_NAME
    update_user
    ;;

  "update")
    # update/modify current user name
    usermod -g $GROUP_NAME $USER_NAME
    update_user
    ;;

  "remove")
    # remove/delete current user name
    userdel -r $USER_NAME
    # groupdel -r $GROUP_NAME $USER_NAME
    ;;

  *)
    echo "Usage: $0 {add | update | remove}"
esac
exit 0
