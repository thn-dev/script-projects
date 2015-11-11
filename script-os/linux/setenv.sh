#!/bin/bash

CLASSPATH=.
export CLASSPATH

JAVA_HOME=/opt/java
export JAVA_HOME

ANT_HOME=/opt/ant
export ANT_HOME

export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$PATH

