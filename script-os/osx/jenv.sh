#!/bin/bash

JAVA_PREFIX=/Library/Java/JavaVirtualMachines

export CLASSPATH=.
export MVN_HOME=/opt/maven


case "$1" in
  '8')
    # export JAVA_HOME=$(/usr/libexec/java_home)
    export JAVA_HOME=${JAVA_PREFIX}/amazon-corretto-8.jdk/Contents/Home
    export PATH=$JAVA_HOME/bin:$MVN_HOME/bin:$PATH
    ;;

  '11')
    export JAVA_HOME=${JAVA_PREFIX}/amazon-corretto-11.jdk/Contents/Home
    export PATH=$JAVA_HOME/bin:$MVN_HOME/bin:$PATH
    ;;

  '15')
    export JAVA_HOME=${JAVA_PREFIX}/amazon-corretto-15.jdk/Contents/Home
    export PATH=$JAVA_HOME/bin:$MVN_HOME/bin:$PATH
    ;;

  *)
    echo
    echo "Usage: $0 { 8 | 11 | 15 }"
    echo

esac
