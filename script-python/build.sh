#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)

MODULE_NAME="<name>"
MODULE_VERSION="<version>"
MODULE_WHEEL_FILE=${MODULE_NAME}-${MODULE_VERSION}-py2-none-any.whl

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
    pip install $CWD/dist/${MODULE_WHEEL_FILE}
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

esac
exit 0
