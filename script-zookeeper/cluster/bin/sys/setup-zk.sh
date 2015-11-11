#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/../setenv.sh

# zookeeper related settings
ZK_ORG=$APP_HOME/zookeeper-3.4.6

if [ -d "$ZK_ORG" ];
then
    # setup app location
    ZKS=zookeeper
    ZK_HOME=$APP_HOME/$ZKS
    ln -s $ZK_ORG $ZK_HOME
    echo "setting up $ZK_HOME"

    cp $CWD/../../conf/zoo.cfg $ZK_HOME/conf/zoo.cfg
    chown -R $USER_NAME:$GROUP_NAME $ZK_HOME

    # setup data location
    ZK_DATA=$APP_DATA/$ZKS

    mkdir -p $ZK_DATA/{data,logs}
    echo 1 > $ZK_DATA/data/myid
    chown -R $USER_NAME:$GROUP_NAME $ZK_DATA
else
    echo "Missing directory: $ZK_ORG"
fi

# create user's bin directory if not exist
USER_BIN=$USER_HOME/bin
if [ ! -d "$USER_BIN" ]; then
    mkdir $USER_BIN
fi

cp -R $CWD/../*.sh $USER_BIN
chown -R $USER_NAME:$GROUP_NAME $USER_BIN
chmod -R 755 $USER_BIN/*.sh
