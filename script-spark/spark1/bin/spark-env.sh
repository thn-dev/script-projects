#!/bin/bash

JAVA_HOME=/opt/java
export JAVA_HOME

SPARK_HOME=/opt/spark
export SPARK_HOME

PATH=$SPARK_HOME/bin:$PATH
export PATH
