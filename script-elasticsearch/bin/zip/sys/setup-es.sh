#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/../@es.setenv-file@

# original path to Hadoop package
ES_ORG="@es.sw@"
ES_HOME="@es.home@"
ES_DATA="@es.path-data@"

if [ -d "$ES_ORG" ];
then
    chown -R $USER_NAME:$GROUP_NAME $ES_ORG

    # create a symlink
    if [ ! -d "$ES_HOME" ];
    then
        ln -s $ES_ORG $ES_HOME
    fi

    # setup data location
    mkdir -p $ES_DATA
    # mkdir -p $ES_DATA/{data,logs,plugins,stopwords}

    chown -R $USER_NAME:$GROUP_NAME $ES_DATA
else
    echo "Missing directory: $ES_ORG"
fi

# create bin directory in user's home
if [ ! -d "$USER_BIN" ];
then
    mkdir -p $USER_BIN
fi

# copy .sh scripts to default user's bin directory
cp -R $CWD/../*.sh $USER_BIN

# setup permission
chown -R $USER_NAME:$GROUP_NAME $USER_BIN
chmod -R 755 $USER_BIN
