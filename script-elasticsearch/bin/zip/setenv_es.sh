#!/bin/bash

APP_HOME=@app.home@
export APP_HOME

APP_DATA=@app.data@
export APP_DATA

USER_NAME=@user.name@
export USER_NAME

# setting for OS X
#USER_HOME=/Users/$USER_NAME

# setting for linux
#USER_HOME=/home/$USER_NAME

USER_HOME=@user.home@
export USER_HOME

USER_BIN=$USER_HOME/bin
export USER_BIN

GROUP_NAME=@group.name@
export GROUP_NAME

CLASSPATH=.
export CLASSPATH

# setting for OS X
# JAVA_HOME=$(/usr/libexec/java_home)

JAVA_HOME=@java.home@
export JAVA_HOME

PATH=$JAVA_HOME/bin:$PATH
export PATH
