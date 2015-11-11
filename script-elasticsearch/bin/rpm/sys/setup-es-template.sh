#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)

ES_CONFIG="@es.path-config@"
if [ -d "$ES_CONFIG" ]; then
    cp $CWD/../../config/@es.config-file.template@ $ES_CONFIG/@es.config-file@
    cp $CWD/../../config/logging.yml $ES_CONFIG
    cp -R $CWD/../../config/stopwords $ES_CONFIG

    cp $CWD/../@startup-file@ @es.startup-file@
    
    # enable service
    chmod u+x @es.startup-file@
    
    # centos 6
    # chkconfig @es.prog@ on
    # service @es.prog@ start
    
    # centos 7
    # systemctl daemon-reload
    # systemctl enable @es.prog@.service
    # systemctl start @es.prog@.service

else
    echo "Missing directory: $ES_CONFIG"
fi
