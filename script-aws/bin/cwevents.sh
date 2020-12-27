#!/usr/bin/env bash

CWD="$( cd "$(dirname "$0")" ; pwd -P )"
. $CWD/env.sh

function list_regions() {
    PREFIX=$1
    shift
    REGIONS=("$@")

    for REGION in ${REGIONS[@]}; do
        list ${PREFIX} ${REGION}
    done
}

function list() {
    PREFIX=$1
    REGION=$2

    echo "# region: ${REGION} (${PREFIX})"
    aws events list-rules --region ${REGION} --name-prefix ${PREFIX}
}

function disable_regions() {
    PREFIX=$1
    COUNT=$2
    shift
    shift
    REGIONS=("$@")

    for REGION in ${REGIONS[@]}; do
        disable_count ${PREFIX} ${REGION} ${COUNT}
    done
}

function disable_count() {
    PREFIX=$1
    REGION=$2
    COUNT=$3

    for index in $(seq 1 $COUNT); do
        disable ${PREFIX} ${REGION} ${index}
    done
}

function disable_range_regions() {
    PREFIX=$1
    FROM=$2
    TO=$3
    shift
    shift
    shift
    REGIONS=("$@")

    for REGION in ${REGIONS[@]}; do
        echo
        echo "# ${REGION}"
        disable_range ${PREFIX} ${REGION} $FROM $TO
    done
}

function disable_range() {
    PREFIX=$1
    REGION=$2
    FROM=$3
    TO=$4

    for index in $(seq $FROM $TO); do
        disable ${PREFIX} ${REGION} ${index}
    done
}

function disable() {
    PREFIX=$1
    REGION=$2
    INDEX=$3

    NAME="${PREFIX}-${INDEX}"
    echo "disable: ${NAME} ($REGION)"

    aws events disable-rule --region ${REGION} --name ${NAME}
}

function enable_regions() {
    PREFIX=$1
    COUNT=$2
    shift
    shift
    REGIONS=("$@")

    for REGION in ${REGIONS[@]}; do
        enable_count ${PREFIX} ${REGION} ${COUNT}
    done
}

function enable_count() {
    PREFIX=$1
    REGION=$2
    COUNT=$3

    for index in $(seq 1 $COUNT); do
        enable ${PREFIX} ${REGION} ${index}
    done
}

function enable() {
    PREFIX=$1
    REGION=$2
    INDEX=$3

    NAME="${PREFIX}-${INDEX}"
    echo "enable: ${NAME} ($REGION)"

    aws events enable-rule --region ${REGION} --name ${NAME}
}

case "$1" in
  'enable.regions')
    enable_regions $2 $3 ${REGIONS_ALL[@]}
    ;;

  'enable.count')
    enable_count $2 $3 $4
    ;;

  'enable')
    enable $2 $3 $4
    ;;

  'disable.regions')
    disable_regions $2 $3 ${REGIONS_ALL[@]}
    ;;

  'disable.count')
    disable_count $2 $3 $4
    ;;

  'disable.range')
    disable_range $2 $3 $4 $5
    ;;

  'disable.range.regions')
    disable_range_regions $2 $3 $4 ${REGIONS_ALL[@]}
    ;;

  'disable')
    disable $2 $3 $4
    ;;

  'list.regions')
    list_regions $2 ${REGIONS_ALL[@]}
    ;;

  'list')
    list $2 $3
    ;;

  # test regions
  'list.regions.test')
    list_regions $2 ${REGIONS_TEST[@]}
    ;;

  'enable.regions.test')
    enable_regions $2 $3 ${REGIONS_TEST[@]}
    ;;

  'disable.regions.test')
    disable_regions $2 $3 ${REGIONS_TEST[@]}
    ;;

  *)
    echo
    echo "Usage: $0 [options]"
    echo "- list <prefix> <region>"
    echo "- list.regions <prefix>"
    echo
    echo "- enable <prefix> <region> <index>"
    echo "- enable.count <prefix> <region> <count>"
    echo "- enable.regions <prefix> <count>"
    echo
    echo "- disable <prefix> <region> <index>"
    echo "- disable.count <prefix> <region> <count>"
    echo "- disable.regions <prefix> <count>"
    echo
    echo "- disable.range <prefix> <region> <from> <to>"
    echo "- disable.range.regions <prefix> <from> <to>"
    echo
    echo "# test regions"
    echo "- list.regions.test <prefix>"
    echo "- enable.regions.test <prefix> <count>"
    echo "- disable.regions.test <prefix> <count>"
    echo
    echo "# examples"
    echo "* ./cwevents.sh list prefix | grep \"region\|Name\|State\""
    echo

esac
exit 0
