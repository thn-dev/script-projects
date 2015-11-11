#!/bin/bash

APP_HOME=@app.home@
export APP_HOME

APP_DATA=@app.data@
export APP_DATA

USER_NAME=@user.name@
export USER_NAME

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
