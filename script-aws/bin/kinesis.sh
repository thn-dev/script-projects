#!/usr/bin/env bash

CWD="$( cd "$(dirname "$0")" ; pwd -P )"
. $CWD/env.sh

: ${STAGE:=test}
: ${PARTY_ID:=ca}
: ${TYPE:=ta}

function list() {
  REGION=$1
  aws kinesis list-streams --region ${REGION}
}

function delete_regions() {
    STAGE=$1
    PARTY_ID=$2
    TYPE=$3

    for REGION in ${REGIONS[@]}; do
        delete ${STAGE} ${PARTY_ID} ${TYPE} ${REGION}
    done
}

function delete() {
    STAGE=$1
    PARTY_ID=$2
    TYPE=$3
    REGION=$4

    STREAM_NAME="${STAGE}.${PARTY_ID}.${TYPE}"
    echo "delete: ${STREAM_NAME} ($REGION)"

    aws kinesis delete-stream --region ${REGION} --stream-name ${STREAM_NAME}
}

function create_regions() {
    STAGE=$1
    PARTY_ID=$2
    TYPE=$3
    SHARDS=$4

    for REGION in ${REGIONS[@]}; do
        create ${STAGE} ${PARTY_ID} ${TYPE} ${REGION} $SHARDS
    done
}

function create() {
    STAGE=$1
    PARTY_ID=$2
    TYPE=$3
    REGION=$4
    SHARDS=$5

    STREAM_NAME="${STAGE}.${PARTY_ID}.${TYPE}"
    echo "stream: ${STREAM_NAME} ($REGION, $SHARDS shards)"

    aws kinesis create-stream --region ${REGION} --stream-name ${STREAM_NAME} --shard-count $SHARDS
}

case "$1" in
  'create.regions')
    create_regions $2 $3 $4 $5
    ;;

  'create')
    create $2 $3 $4 $5 $6
    ;;

  'delete.regions')
    delete_regions $2 $3 $4
    ;;

  'delete')
    delete $2 $3 $4 $5
    ;;

  'list')
    list $2
    ;;

  *)
    echo
    echo "Usage: $0 [options]"
    echo "- list <region>"
    echo
    echo "- delete <stage> <party id> <type> <region>"
    echo "- delete.regions <stage> <party id> <type>"
    echo
    echo "- create <stage> <party id> <type> <region> <shard count>"
    echo "- create.regions <stage> <party id> <type> <shard count>"
    echo

esac
exit 0
