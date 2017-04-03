#!/bin/bash

APP_HOME=/opt
export APP_HOME

APP_DATA=/data
export APP_DATA

USER_NAME=hduser
export USER_NAME

# setting for OS X
# USER_HOME=/Users/$USER_NAME

# setting for linux
USER_HOME=/home/$USER_NAME
export USER_HOME

GROUP_NAME=hadoop
export GROUP_NAME

CLASSPATH=.
export CLASSPATH

# setting for OS X
# JAVA_HOME=$(/usr/libexec/java_home)

# setting for linux
JAVA_HOME=/opt/java
export JAVA_HOME

PATH=$JAVA_HOME/bin:$PATH
export PATH
