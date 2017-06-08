#!/bin/bash

APP_HOME=/opt
export APP_HOME

APP_DATA=/data
export APP_DATA

APP_NAME=yarn
export APP_NAME

USER_NAME=yarn
export USER_NAME

# setting for OS X
#USER_HOME=/Users/$USER_NAME

# setting for linux
USER_HOME=/home/$USER_NAME
export USER_HOME

USER_BIN=$USER_HOME/bin
export USER_BIN

GROUP_NAME=hadoop
export GROUP_NAME

CLASSPATH=.
export CLASSPATH

# setting for OS X
#JAVA_HOME=$(/usr/libexec/java_home)

JAVA_HOME=$APP_HOME/java
export JAVA_HOME

HADOOP_PREFIX=$APP_HOME/$APP_NAME
export HADOOP_PREFIX

HADOOP_DATA=$APP_DATA/$APP_NAME
export HADOOP_DATA

PATH=$JAVA_HOME/bin:$HADOOP_PREFIX/bin:$PATH
export PATH
