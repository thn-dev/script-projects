#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/../setenv.sh

# solr related settings
SOLR_ORG=$APP_HOME/solr-4.7.0

SOLR_COLLECTION=indexcloud

# setup application location
if [ -d "$SOLR_ORG" ];
then
    # create solr instances
    for i in {1..3}
    do
        SOLR_NAME=solr0$i

        # setup app location
        SOLR_HOME=$APP_HOME/$SOLR_NAME
        echo "setting up $SOLR_HOME"

        cp -R $SOLR_ORG/example $SOLR_HOME
        rm -rf $SOLR_HOME/example*
        rm -rf $SOLR_HOME/multicore
        chown -R $USER_NAME:$GROUP_NAME $SOLR_HOME

        # setup data location
        SOLR_DATA=$APP_DATA/$SOLR_NAME

        mv $SOLR_HOME/solr $SOLR_DATA
        mv $SOLR_DATA/collection1 $SOLR_DATA/$SOLR_COLLECTION
        cp $CWD/../../conf/core$i.properties $SOLR_DATA/$SOLR_COLLECTION/core.properties
        cp $CWD/../../conf/schema.xml $SOLR_DATA/$SOLR_COLLECTION/conf
        chown -R $USER_NAME:$GROUP_NAME $SOLR_DATA
    done
    rm -rf $SOLR_ORG
else
    echo "Missing directory: $SOLR_ORG"
fi

# create user's bin directory if not exist
USER_BIN=$USER_HOME/bin
if [ ! -d "$USER_BIN" ]; then
    mkdir $USER_BIN
fi

cp -R $CWD/../*.sh $USER_BIN
chown -R $USER_NAME:$GROUP_NAME $USER_BIN
chmod -R 755 $USER_BIN/*.sh
