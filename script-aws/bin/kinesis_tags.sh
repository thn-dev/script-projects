#!/usr/bin/env bash

CWD="$( cd "$(dirname "$0")" ; pwd -P )"
. $CWD/env.sh

REGION="us-east-1"

KEY_1=12345
KEY_2="test_name"

declare -a TEST_STREAMS=(
  "test.a"
  "test.b"
)

function list() {
  REGION=$1
  aws kinesis list-streams --region ${REGION}
}

function list_tags_streams() {
    REGION=$1
    shift
    STREAMS=("$@")

    for STREAM in ${STREAMS[@]}; do
        list_tags_stream ${REGION} ${STREAM}
    done
}

function list_tags_stream() {
  REGION=$1
  STREAM=$2

  echo "# stream: ${STREAM} (${REGION})"
  aws kinesis list-tags-for-stream --region ${REGION} --stream-name ${STREAM}
}

function tag_streams() {
    REGION=$1
    shift
    STREAMS=("$@")

    for STREAM in ${STREAMS[@]}; do
        tag ${REGION} ${STREAM} ${KEY_1} ${KEY_2}
    done
}

function tag() {
    REGION=$1
    STREAM=$2
    KEY_1=$3
    KEY_2=$4

    echo "# stream: ${STREAM} (${REGION})"

    if [ ! -z $2 ]; then
        PREFIX=$2
    fi

    aws kinesis add-tags-to-stream --region ${REGION} \
        --stream-name ${STREAM} \
        --cli-input-json "{\"StreamName\": \"${STREAM}\", \"Tags\": { \"key1\":\"${KEY_1}\",\"key2\":\"${KEY_2}\"}}"
}

case "$1" in
  'test.tag.streams')
    tag_streams ${REGION} ${TEST_STREAMS[@]}
    ;;

  'test.list.tags')
    list_tags_streams ${REGION} ${TEST_STREAMS[@]}
    ;;

  'tag')
    tag $2 $3 $4 $5
    ;;

  'list')
    list $2
    ;;

  'list.tags.stream')
    list_tags_stream $2 $3
    ;;

  *)
    echo
    echo "Usage: $0 [options]"
    echo "- list <region>"
    echo "- list.tags.stream <region> <stream name>"
    echo
    echo "- tag <region> <stream name> <key 1> <key 2>"
    echo
    echo "# test streams"
    echo "- test.list.tags"
    echo "- test.tag.streams"
    echo

esac
exit 0
