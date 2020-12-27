#!/usr/bin/env bash

CWD="$( cd "$(dirname "$0")" ; pwd -P )"
. $CWD/env.sh

SERVICE="sqs"

function list_regions() {
    PARTY_ID=$1
    shift
    REGIONS=("$@")

    for REGION in ${REGIONS[@]}; do
        list ${REGION} ${PARTY_ID}
    done
}

function list() {
    REGION=$1

    echo "# region: ${REGION}"

    if [ ! -z $2 ]; then
        PARTY_ID=$2
        aws ${SERVICE} list-queues --region ${REGION} | grep ${PARTY_ID}
    else
        aws ${SERVICE} list-queues --region ${REGION}
    fi
}

function list_regions_tags() {
    PARTY_ID=$1
    STAGE=$2
    TYPE=$3
    shift
    shift
    shift
    REGIONS=("$@")

    QUEUE_NAME="${STAGE}-${PARTY_ID}-${TYPE}"
    for REGION in ${REGIONS[@]}; do
        list_tags ${REGION} ${QUEUE_NAME}
    done
}

function list_tags() {
    REGION=$1
    QUEUE_NAME=$2

    QUEUE_URL="https://sqs.${REGION}.amazonaws.com/${ACCOUNT_ID}/${QUEUE_NAME}"
    echo "tags: ${QUEUE_URL} ($REGION)"

    aws ${SERVICE} list-queue-tags --queue-url ${QUEUE_URL} \
        --region ${REGION}
}

function delete_regions() {
    PARTY_ID=$1
    STAGE=$2
    TYPE=$3

    for REGION in ${REGIONS[@]}; do
        delete ${PARTY_ID} ${STAGE} ${TYPE} ${REGION}
    done
}

function delete() {
    PARTY_ID=$1
    STAGE=$2
    TYPE=$3
    REGION=$4

    QUEUE_NAME="${STAGE}-${PARTY_ID}-${TYPE}"
    QUEUE_URL="https://sqs.${REGION}.amazonaws.com/${ACCOUNT_ID}/${QUEUE_NAME}"
    echo "delete: ${QUEUE_URL} ($REGION)"

    aws ${SERVICE} delete-queue --queue-url ${QUEUE_URL} \
        --region ${REGION}
}

function delete_queue_url() {
    REGION=$1
    QUEUE_URL=$2

    echo "delete: ${QUEUE_URL} ($REGION)"

    aws ${SERVICE} delete-queue --queue-url ${QUEUE_URL} \
        --region ${REGION}
}

function purge_regions() {
    PARTY_ID=$1
    STAGE=$2
    TYPE=$3
    shift
    shift
    shift
    REGIONS=("$@")

    for REGION in ${REGIONS[@]}; do
        purge ${PARTY_ID} ${STAGE} ${TYPE} ${REGION}
    done
}

function purge() {
    PARTY_ID=$1
    STAGE=$2
    TYPE=$3
    REGION=$4

    QUEUE_NAME="${STAGE}-${PARTY_ID}-${TYPE}"
    QUEUE_URL="https://sqs.${REGION}.amazonaws.com/${ACCOUNT_ID}/${QUEUE_NAME}"
    echo "purge: ${QUEUE_URL} ($REGION)"

    aws ${SERVICE} purge-queue --queue-url ${QUEUE_URL} \
        --region ${REGION}
}

function create_regions() {
    PARTY_ID=$1
    STAGE=$2
    TYPE=$3

    for REGION in ${REGIONS[@]}; do
        create ${PARTY_ID} ${STAGE} ${TYPE} ${REGION}
    done
}

function create() {
    PARTY_ID=$1
    STAGE=$2
    TYPE=$3
    REGION=$4

    QUEUE_NAME="${STAGE}-${PARTY_ID}-${TYPE}"
    echo "queue: ${QUEUE_NAME} ($REGION)"

    aws ${SERVICE} create-queue --queue-name ${QUEUE_NAME} \
        --region ${REGION}
}

case "$1" in
  'create.queue.regions')
    create_regions $2 $3 $4
    ;;

  'create.queue')
    create $2 $3 $4 $5
    ;;

  'delete.queue.url')
    delete_queue_url $2 $3
    ;;

  'delete.queue.regions')
    delete_regions $2 $3 $4
    ;;

  'delete.queue')
    delete $2 $3 $4 $5
    ;;

  'purge.queue.regions')
    purge_regions $2 $3 $4 ${REGIONS[@]}
    ;;

  'purge.queue')
    purge $2 $3 $4 $5
    ;;

  'list.regions.tags')
    list_regions_tags $2 $3 $4 ${REGIONS[@]}
    ;;

  'list.regions')
    list_regions $2 ${REGIONS[@]}
    ;;

  'list')
    list $2 $3
    ;;

  'list.tags')
    list_tags $2 $3
    ;;

  'purge.queue.regions.test')
    purge_regions $2 $3 $4 ${REGIONS_TEST[@]}
    ;;

  'list.regions.test')
    list_regions $2 ${REGIONS_TEST[@]}
    ;;

  'list.regions.test.tags')
    list_regions_tags $2 $3 $4 ${REGIONS_TEST[@]}
    ;;

  *)
    echo
    echo "Usage: $0 [options]"
    echo "- list <region>"
    echo "- list.tags <region> <queue name>"
    echo "- list.regions <party id>"
    echo "- list.regions.tags <party id> <stage> <type>"
    echo
    echo "- delete.queue.url <region> <url>"
    echo "- delete.queue <party id> <stage> <type> <region>"
    echo "- delete.queue.region <party id> <stage> <type>"
    echo
    echo "- create.queue <party id> <stage> <type> <region>"
    echo "- create.queue.regions <party id> <stage> <type>"
    echo
    echo "- purge.queue <party id> <stage> <type> <region>"
    echo "- purge.queue.regions <party id> <stage> <type>"
    echo
    echo "- list.regions.test <party id>"
    echo "- list.regions.test.tags <party id> <stage> <type>"
    echo "- purge.queue.regions.test <party id> <stage> <type>"
    echo

esac
exit 0
