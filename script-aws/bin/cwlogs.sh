#!/usr/bin/env bash

CWD="$( cd "$(dirname "$0")" ; pwd -P )"
. $CWD/env.sh

declare -a REGIONS=${REGIONS_ALL[@]}

function list_regions() {
    PREFIX=$1

    for REGION in ${REGIONS[@]}; do
        list ${PREFIX} ${REGION}
    done
}

function list() {
    PREFIX=$1
    REGION=$2

    echo "# log groups: ${PREFIX} in ${REGION}"
    aws logs describe-log-groups --region ${REGION} --log-group-name-prefix ${PREFIX} | grep logGroupName
}

function delete_regions() {
    PREFIX=$1
    COUNT=$2

    for REGION in ${REGIONS[@]}; do
        delete_count ${PREFIX} ${REGION} ${COUNT}
    done
}

function delete_count() {
    PREFIX=$1
    REGION=$2
    COUNT=$3

    for index in $(seq 1 $COUNT); do
        delete ${PREFIX} ${REGION} ${index}
    done
}

function delete() {
    PREFIX=$1
    REGION=$2
    INDEX=$3

    NAME="${PREFIX}-${INDEX}"
    echo "delete: ${NAME} ($REGION)"

    aws logs delete-log-group --region ${REGION} --log-group-name ${NAME}
}

function create_regions() {
    PREFIX=$1
    COUNT=$2

    for REGION in ${REGIONS[@]}; do
        create_count ${PREFIX} ${REGION} ${COUNT}
    done
}

function create_count() {
    PREFIX=$1
    REGION=$2
    COUNT=$3

    for index in $(seq 1 $COUNT); do
        delete ${PREFIX} ${REGION} ${index}
    done
}

function create() {
    PREFIX=$1
    REGION=$2
    INDEX=$3

    NAME="${PREFIX}-${INDEX}"
    echo "delete: ${NAME} ($REGION)"

    aws logs create-log-group --log-group-name ${NAME} \
        --region ${REGION}
}

case "$1" in
  'create.regions')
    create_regions $2 $3
    ;;

  'create.count')
    create_count $2 $3 $4
    ;;

  'create')
    create $2 $3 $4
    ;;

  'delete.regions')
    delete_regions $2 $3
    ;;

  'delete.count')
    delete_count $2 $3 $4
    ;;

  'delete')
    delete $2 $3 $4
    ;;

  'list.regions')
    list_regions $2
    ;;

  'list')
    list $2 $3
    ;;

  *)
    echo
    echo "Usage: $0 [options]"
    echo "- list <prefix> <region>"
    echo "- list.regions <prefix>"
    echo
    echo "- delete <prefix> <region> <index>"
    echo "- delete.count <prefix> <region> <count>"
    echo "- delete.regions <prefix> <count>"
    echo
    echo "- create <prefix> <region> <index>"
    echo "- create.count <prefix> <region> <count>"
    echo "- create.regions <prefix> <count>"
    echo

esac
exit 0
