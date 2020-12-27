#!/usr/bin/env bash

CWD="$( cd "$(dirname "$0")" ; pwd -P )"
. $CWD/env.sh

: ${STAGE:=dev}
: ${PARTY_ID:=12345}
: ${TYPE:=post}

function s3_list() {
  aws s3api list-buckets
}

function s3_delete_regions() {
    STAGE=$1
    PARTY_ID=$2
    TYPE=$3
    shift
    shift
    shift
    REGIONS=("$@")

    for REGION in ${REGIONS[@]}; do
        s3_delete ${STAGE} ${PARTY_ID} ${TYPE} ${REGION}
    done
}

function s3_delete() {
    PREFIX=$1
    REGION=$2

    BUCKET_NAME="${PREFIX}-${REGION}"
    echo "bucket: ${BUCKET_NAME}"
    echo

    aws s3api delete-bucket --bucket ${BUCKET_NAME} \
        --region ${REGION}
}

function s3_create_regions() {
    PREFIX=$1
    shift
    REGIONS=("$@")

    for REGION in ${REGIONS[@]}; do
        echo "# creating: ${PREFIX}-${REGION}"
        s3_create ${PREFIX} ${REGION}
    done
}

function s3_create() {
    PREFIX=$1
    REGION=$2

    BUCKET_NAME="${PREFIX}-${REGION}"
    echo "- bucket: ${BUCKET_NAME}"

    aws s3api create-bucket --bucket ${BUCKET_NAME} \
        --region ${REGION} \
        --create-bucket-configuration LocationConstraint=${REGION}
}

case "$1" in
  'create.bucket.regions')
    s3_create_regions $2 ${REGIONS_ALL[@]}
    ;;

  'create.bucket')
    s3_create $2 $3 $4 $5
    ;;

  'delete.bucket.regions')
    s3_delete_regions $2 $3 $4
    ;;

  'delete.bucket')
    s3_delete $2 $3 $4 $5
    ;;

  'list')
    s3_list $2
    ;;

  'test')
    dummy
    ;;

  *)
    echo
    echo "Usage: $0 [options]"
    echo "- list"
    echo
    echo "- delete.bucket <bucket name>"
    echo "- delete.bucket.regions <bucket prefix>"
    echo
    echo "- create.bucket <bucket name>"
    echo "- create.bucket.regions <bucket prefix>"
    echo

esac
exit 0
