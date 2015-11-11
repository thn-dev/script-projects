#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/../setenv.sh

# zookeeper related settings
ZK_ORG=$APP_HOME/zookeeper-3.4.6

# setup application location
if [ -d "$ZK_ORG" ];
then
    # create zookeeper instances
    for i in {1..3}
    do
        ZKS=zks$i
    
        # setup app location
        ZK_HOME=$APP_HOME/$ZKS
        echo "setting up $ZK_HOME"

        cp -R $ZK_ORG $ZK_HOME
        cp $CWD/../../conf/zoo$i.cfg $ZK_HOME/conf/zoo.cfg
        chown -R $USER_NAME:$GROUP_NAME $ZK_HOME
        
        # setup data location
        ZK_DATA=$APP_DATA/$ZKS
        
        mkdir -p $ZK_DATA/{data,logs}
        echo $i > $ZK_DATA/data/myid
        chown -R $USER_NAME:$GROUP_NAME $ZK_DATA
    done
    rm -rf $ZK_ORG
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


