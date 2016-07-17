#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/setenv.sh

HADOOP_PREFIX=$APP_HOME/hadoop/
export HADOOP_PREFIX
