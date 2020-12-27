#!/bin/bash

CWD="$( cd "$(dirname "$0")" ; pwd -P )"
APP_HOME="$(dirname "$CWD")"
APP_LIB=$CWD/../lib
APP_CONFIG=$CWD/../config

for i in "$APP_LIB"/*.jar; do
  LIB_JARS=$LIB_JARS,$i
done

LIB_JARS=`echo $LIB_JARS | cut -c2-`
#APP_JARS=`echo $LIB_JARS | sed 's/:/,/g'`
APP_JARS=$LIB_JARS

CLASSPATH=$APP_JARS:$APP_CONFIG
export CLASSPATH

SERVICE_NAME="a"
PID_FILE="${APP_HOME}/${SERVICE_NAME}.pid"
APP_OPTS="-Dlog4j.configurationFile=$APP_CONFIG/${SERVICE_NAME}.xml"
APP_OPTS="$APP_OPTS -Dconfig.file=$APP_CONFIG/${SERVICE_NAME}.yml"
APP_OPTS="$APP_OPTS -Xms1g -Xmx2g"
APP_OPTS="$APP_OPTS -Dcom.amazonaws.sdk.disableCbor"
APP_NAME="b"

START_COMMAND="java $APP_OPTS $APP_NAME"

. $CWD/common.sh