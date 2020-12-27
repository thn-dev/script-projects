#!/usr/bin/env bash

CWD="$( cd "$(dirname "$0")" ; pwd -P )"
. $CWD/env.sh

KEY_1=12345
KEY_2="test_name"

SERVICE="lambda"

declare -a ARNS=(
    "arn1"
    "arn2"
)

function resource_arn() {
    REGION=$1
    FNAME=$2

    echo "arn:aws:lambda:${REGION}:${ACCOUNT_ID}:function:${FNAME}"
}

function list_regions() {
    for REGION in ${REGIONS[@]}; do
        if [ ! -z $1 ]; then
            PREFIX=$1
            list ${REGION} ${PREFIX}
        else
            list ${REGION}
        fi
    done
}

function list() {
    REGION=$1

    echo "# ${SERVICE} list in ${REGION}"

    if [ ! -z $2 ]; then
        PREFIX=$2
        aws ${SERVICE} list-functions --region ${REGION} | grep ${PREFIX}
    else
        aws ${SERVICE} list-functions --region ${REGION}
    fi
}

function list_tags_prefix_regions() {
    PREFIX=$1
    COUNT=$2
    shift
    shift

    REGIONS=("$@")

    for REGION in ${REGIONS[@]}; do
        list_tags_prefix $REGION $PREFIX $COUNT
    done
}

function list_tags_prefix() {
    REGION=$1
    PREFIX=$2
    COUNT=$3

    for index in $(seq 1 $COUNT); do
        FNAME="${PREFIX}-${index}"
        ARN="$(resource_arn ${REGION} ${FNAME})"
        list_tags ${REGION} ${ARN}
    done
}

function list_tags_arns() {
    REGION=$1
    shift
    ARNS=("$@")

    for ARN in ${ARNS[@]}; do
        list_tags ${REGION} ${ARN}
    done
}

function list_tags() {
    REGION=$1
    ARN=$2

    echo "resource: ${ARN}"
    aws ${SERVICE} list-tags --region ${REGION} --resource ${ARN}
}

function tag_resource_regions() {
    PREFIX=$1
    COUNT=$2

    for REGION in ${REGIONS[@]}; do
        tag_resource_count $REGION $PREFIX $COUNT
    done
}

function tag_resource_count() {
    REGION=$1
    PREFIX=$2
    COUNT=$3

    tag_resource_range ${REGION} ${PREFIX} 1 ${COUNT}
}

function tag_resource_range() {
    REGION=$1
    PREFIX=$2
    START=$3
    END=$4

    for index in $(seq $START $END); do
        FNAME="${PREFIX}-${index}"
        ARN="$(resource_arn ${REGION} ${FNAME})"
        tag_resource ${REGION} ${ARN}
    done
}

function tag_resource() {
    REGION=$1
    ARN=$2

    echo "tagging: ${ARN} with (${KEY_1}, ${KEY_2})"
    aws ${SERVICE} tag-resource --region ${REGION} --resource ${ARN} \
        --tags "{\"key1\":\"${KEY_1}\",\"key2\":\"${KEY_2}\"}"
}

case "$1" in
  'list.regions')
    list_regions $2
    ;;

  'list')
    list $2 $3
    ;;

  'list.tags')
    list_tags $2 $3
    ;;

  'list.tags.prefix')
    list_tags_prefix $2 $3 $4
    ;;

  'list.tags.prefix.regions')
    list_tags_prefix_regions $2 $3 ${REGIONS[@]}
    ;;

  'list.tags.arns')
    list_tags_arns $2 ${ARNS[@]}
    ;;

  'tag')
    tag_resource $2 $3
    ;;

  'tag.count')
    tag_resource_count $2 $3 $4
    ;;

  'tag.range')
    tag_resource_range $2 $3 $4 $5
    ;;

  'tag.count.regions')
    tag_resource_regions $2 $3
    ;;

  *)
    echo
    echo "Usage: $0 [options]"
    echo "- list <region> [prefix]"
    echo "- list.regions [prefix]"
    echo
    echo "- list.tags <region> <resource>"
    echo "- list.tags.prefix <region> <resource prefix> <count>"
    echo "- list.tags.prefix.regions <resource prefix> <count>"
    echo
    echo "- list.tags.arns <region>"
    echo
    echo "# tagging for prod environment"
    echo "- tag <region> <arn>"
    echo "- tag.range <region> <prefix> <start> <end>"
    echo "- tag.count <region> <prefix> <count>"
    echo "- tag.count.regions <prefix> <count>"
    echo

esac
exit 0
