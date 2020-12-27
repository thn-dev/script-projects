#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/build.sh

MODULE_NAME="<name>"
MODULE_VERSION="<version>"

CORE_MODULE=${MODULE_NAME}-${MODULE_VERSION}

LOCATION_DEV_ENV=$HOME/dev/env/
LOCATION_AWS=$CWD/deploy/aws/

VIRTUAL_ENV_PACKAGES=lib/python2.7/site-packages

case "$1" in
  'clean')
    rm -rf $CWD/{build,deploy,dist,${MODULE_NAME}.egg-info}
    ;;

  'install')
    python setup.py install
    ;;

  'build.src')
    python setup.py sdist
    ;;
        
  'build.wheel')
    python setup.py bdist_wheel
    ;;

  'deploy.local')
    $0 build.wheel
    pip install $CWD/dist/${CORE_MODULE}-py2-none-any.whl
    ;;

  'add.lambda')
    cd $CWD/lambda
    zip -g $2 lambda_config.py
    zip -g $2 lambda_module.py
    
    cd $CWD
    ;;
    
  'build.aws')
    # goto path/to/<virtualenv location>
    VIRTUAL_ENV_DIR=$2
    cd $VIRTUAL_ENV_DIR
    
    # then goto <ENV>/lib/python2.7/site-packages
    # cd lib/python2.7/site-packages
    cd $VIRTUAL_ENV_PACKAGES

    # zip everything recursively to $ZIP_FILE
    ZIP_FILE=$3

    echo -e "# creating $ZIP_FILE"
    zip -r9 $ZIP_FILE *
    cd $CWD
    
    # add lambda-related modules into $ZIP_FILE
    echo -e "# adding lambda modules to $ZIP_FILE"
    $0 add.lambda $ZIP_FILE
    cd $CWD
    ;;

  'deploy.aws')
    if [ ! -d "$LOCATION_AWS" ]; then
      mkdir -p $LOCATION_AWS
    fi

    $0 deploy.local ${CORE_MODULE}

    OUTPUT_FILE=${CORE_MODULE}.zip
    if [ ! -z $2 ]; then
      OUTPUT_FILE=${CORE_MODULE}_$2.zip
    fi

    $0 build.aws $LOCATION_DEV_ENV $LOCATION_AWS/${OUTPUT_FILE}
    ;;

  'update.aws')
    ZIP_FILE=$LOCATION_AWS/${CORE_MODULE}_$2.zip
    $0 add.lambda $ZIP_FILE
    ;;

  *)
    echo "Usage: $0 options"
    echo "where options are"
    echo "- clean   # clean directories"
    echo "- install # install to virtual environment"
    echo
    echo "# for local deployment"
    echo "- build.src   # build project"
    echo "- build.wheel # build project in wheel file for deployment"
    echo "- deploy.local <file prefix>-<version> (i.e test-0.0.1)"
    echo
    echo "# for aws deployment"
    echo "- add.lambda path/to/zipfile"
    echo "- build.aws path/to/virtualenv path/to/zipfile"
    echo "- deploy.aws yyyymmdd"
    echo

esac
exit 0
