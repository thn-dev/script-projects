
#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/../yarn-env.sh

# original path to Hadoop package
HADOOP_ORG=$APP_HOME/hadoop-2.7.3

if [ -d "$HADOOP_ORG" ]; then
  # create a symlink
  HADOOP_PREFIX=$APP_HOME/yarn
  if [ ! -d "$HADOOP_PREFIX" ]; then
      ln -s $HADOOP_ORG $HADOOP_PREFIX
  fi
  chown -R $USER_NAME:$GROUP_NAME $HADOOP_ORG

  # setup conf files
  HADOOP_CFG=$HADOOP_PREFIX/etc/hadoop
  cp -R $CWD/../../conf/* $HADOOP_CFG

  # setup data location
  # HADOOP_DATA=$APP_DATA/yarn
  HADOOP_DATA=$HADOOP_DATA
  mkdir -p $HADOOP_DATA/{dfs,mapred,logs,pids,local}
  mkdir -p $HADOOP_DATA/dfs/{nn,sn,dn}
  mkdir -p $HADOOP_DATA/mapred/{local,temp,system}

  chown -R $USER_NAME:$GROUP_NAME $HADOOP_DATA
else
  echo "Missing directory: $HADOOP_ORG"
fi

# create bin directory in user's home
USER_BIN=$USER_HOME/bin
if [ ! -d "$USER_BIN" ]; then
    mkdir -p $USER_BIN
fi

# copy .sh scripts to default user's bin directory
cp setup-ssh.sh $USER_BIN
cp setup-ssh_share.sh $USER_BIN
cp -R $CWD/../*.sh $USER_BIN

# setup permission
chown -R $USER_NAME:$GROUP_NAME $USER_BIN
chmod -R 755 $USER_BIN/*.sh
