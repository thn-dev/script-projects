#!/bin/bash

APP_HOME=/opt
export APP_HOME

APP_DATA=/data
export APP_DATA

USER_NAME=hduser
export USER_NAME

USER_HOME=/Users/$USER_NAME
export USER_HOME

GROUP_NAME=hadoop
export GROUP_NAME

CLASSPATH=.
export CLASSPATH

JAVA_HOME=$(/usr/libexec/java_home)
export JAVA_HOME

PATH=$JAVA_HOME/bin:$PATH
export PATH
