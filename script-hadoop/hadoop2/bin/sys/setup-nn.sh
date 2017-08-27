
#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/../yarn-env.sh

# setup hadoop dfs for namenode
mkdir -p $HADOOP_DATA/dfs/nn
chown -R $USER_NAME:$GROUP_NAME $HADOOP_DATA

# create bin directory in user's home
USER_BIN=$USER_HOME/bin
if [ ! -d "$USER_BIN" ]; then
    mkdir -p $USER_BIN
fi

# copy .sh scripts to default user's bin directory
cp setup-ssh.sh $USER_BIN
cp setup-ssh_share.sh $USER_BIN
cp setup-ssh_share-hosts.sh $USER_BIN
cp remote.sh $USER_BIN
cp -R $CWD/../*.sh $USER_BIN

# setup permission
chown -R $USER_NAME:$GROUP_NAME $USER_BIN
chmod -R 755 $USER_BIN/*.sh
