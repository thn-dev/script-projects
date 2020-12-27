#!/usr/bin/env bash

CWD="$( cd "$(dirname "$0")" ; pwd -P )"
. $CWD/env.sh

declare -a TAGS_DEV=(
    "Key=tag.key1,Value=test_name"
    "Key=tag.key2,Value=12345"
)


declare -a TABLES=(
    "PREFIX_TABLE_A"
)

function resource_arn() {
    TABLE=$1
    REGION=$2

    echo "arn:aws:dynamodb:${REGION}:${ACCOUNT_ID}:table/${TABLE}"
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

    echo "# dynamodb list in ${REGION}"

    if [ ! -z $2 ]; then
        PREFIX=$2
        aws dynamodb list-tables --region ${REGION} | grep ${PREFIX}
    else
        aws dynamodb list-tables --region ${REGION}
    fi
}

function list_tags_tables() {
    REGION=$1

    for TABLE in ${TABLES[@]}; do
        list_tags ${REGION} ${TABLE}
    done
}

function list_tags() {
    REGION=$1
    TABLE=$2

    ARN="$(resource_arn ${TABLE} ${REGION})"
    echo "# arn: ${ARN}"

    aws dynamodb list-tags-of-resource --region ${REGION} --resource-arn ${ARN}
}

function tag_tables() {
    REGION=$1
    shift
    TAGS=("$@")

    for TABLE in ${TABLES[@]}; do
        tag ${REGION} ${TABLE} ${TAGS[@]}
    done
}

function tag() {
    REGION=$1
    TABLE=$2
    shift
    shift
    TAGS=("$@")

    ARN="$(resource_arn ${TABLE} ${REGION})"
    echo "tagging: ${ARN} with (${TAGS[@]})"

    aws dynamodb tag-resource --resource-arn ${ARN} --tags ${TAGS[@]}
}

function delete_tables() {
    REGION=$1
    shift

    TABLES=("$@")

    for TABLE in ${TABLES[@]}; do
        delete_table ${REGION} ${TABLE}
    done

}

function delete_table() {
    REGION=$1
    TABLE=$2

    echo "deleting: ${TABLE} (${REGION})"
    aws dynamodb delete-table --region ${REGION} --table-name ${TABLE}
}

case "$1" in
  'list.regions')
    list_regions $2
    ;;

  'list')
    list $2 $3
    ;;

  'list.tags.tables')
    list_tags_tables $2
    ;;

  'list.tags')
    list_tags $2 $3
    ;;

  'tag.dev.tables')
    tag_tables $2 ${TAGS_DEV[@]}
    ;;

  'tag.dev')
    tag $2 $3 ${TAGS_DEV[@]}
    ;;

  'delete.table')
    delete_table $2 $3
    ;;

  'delete.tables')
    delete_tables $2 ${TABLES[@]}
    ;;

  *)
    echo
    echo "Usage: $0 [options]"
    echo "# tagging for dev environment"
    echo "- tag.dev <region> <table>"
    echo "- tag.dev.tables <region>"
    echo
    echo "- delete.table <region> <table>"
    echo "- delete.tables <region>"
    echo
    echo "- list <region>"
    echo "- list.regions <prefix>"
    echo
    echo "- list.tags <region> <table>"
    echo "- list.tags.tables <region>"
    echo

esac
exit 0
