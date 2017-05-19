#!/bin/bash

export CLASSPATH=.
export JAVA_HOME=/opt/java

export ANT_HOME=/opt/ant
export MVN_HOME=/opt/maven

export GRADLE_HOME=/opt/gradle

# https://golang.org/doc/install/source#environment
# GOOS
# GOARCH

export GOROOT=/opt/go
export GOBIN=$GOROOT/bin
export GOPATH=$HOME/dev.go

export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$MVN_HOME/bin:$GOROOT/bin:$PATH

