#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/../@es.setenv-file@

# setup data location
ES_DATA="@es.path-data@"
if [ -d "$ES_DATA" ];
then
    mkdir -p $ES_DATA
    chown -R $USER_NAME:$GROUP_NAME $ES_DATA
else
    echo "Missing directory: $ES_DATA"
fi

# setup configuration location
ES_CONFIG="@es.path-config@"
if [ -d "$ES_CONFIG" ]; then
    mkdir -p $ES_CONFIG
    chown -R $USER_NAME:$GROUP_NAME $ES_CONFIG
fi

# setup data log location
ES_LOGS="@es.path-logs@"
if [ -d "$ES_LOGS" ]; then
    mkdir -p $ES_LOGS
    chown -R $USER_NAME:$GROUP_NAME $ES_LOGS
fi

# setup pid location
ES_PID="@es.path-pid@"
if [ -d "$ES_PID" ]; then
    mkdir -p $ES_PID
    chown -R $USER_NAME:$GROUP_NAME $ES_PID
fi

# setup plugins location
ES_PLUGINS="@es.path-plugins@"
if [ -d "$ES_PLUGINS" ]; then
    mkdir -p $ES_PLUGINS
    chown -R $USER_NAME:$GROUP_NAME $ES_PLUGINS
fi
