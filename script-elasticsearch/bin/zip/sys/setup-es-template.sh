#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)

ES_CONFIG="@es.path-config@"
if [ -d "$ES_CONFIG" ]; then
    cp $CWD/../../config/@es.config-file.template@ $ES_CONFIG/@es.config-file@
    cp -R $CWD/../../config/stopwords $ES_CONFIG
else
    echo "Missing directory: $ES_CONFIG"
fi
