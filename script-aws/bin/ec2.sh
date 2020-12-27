#!/usr/bin/env bash

CWD="$( cd "$(dirname "$0")" ; pwd -P )"
. $CWD/env.sh

# REGIONS_TEST from env.sh
declare -a REGIONS=${REGIONS_TEST[@]}

function copy_image_regions() {
    IMAGE_NAME=$1
    SRC_AMI_ID=$2
    SRC_REGION=$3
    shift
    shift
    shift
    REGIONS=("$@")

    for DST_REGION in ${REGIONS[@]}; do
        copy_image ${IMAGE_NAME} ${SRC_AMI_ID} ${SRC_REGION} ${DST_REGION}
    done
}

function copy_image() {
    IMAGE_NAME=$1
    SRC_AMI_ID=$2
    SRC_REGION=$3
    DST_REGION=$4

    echo "# copy-image (${SRC_AMI_ID}) from ${SRC_REGION} to ${DST_REGION}"
    aws ec2 copy-image --source-image-id ${SRC_AMI_ID} --source-region ${SRC_REGION} --region ${DST_REGION} --name ${IMAGE_NAME}
}

function import_keypair_regions() {
    KEY_NAME=$1
    KEY_FILE=$2
    shift
    shift
    REGIONS=("$@")

    for REGION in ${REGIONS[@]}; do
        import_keypair ${KEY_NAME} ${KEY_FILE} ${REGION}
    done
}

function import_keypair() {
    KEY_NAME=$1
    KEY_FILE=$2
    REGION=$3

    echo "# import-key-pair: ${KEY_NAME} (${REGION})"
    aws ec2 import-key-pair --key-name ${KEY_NAME} --public-key-material file://${KEY_FILE} --region ${REGION}
}

function delete_keypair_regions() {
    KEY_NAME=$1
    shift
    REGIONS=("$@")

    for REGION in ${REGIONS[@]}; do
        delete_keypair ${KEY_NAME} ${REGION}
    done
}

function delete_keypair() {
    KEY_NAME=$1
    REGION=$2

    echo "# delete-key-pair: ${KEY_NAME} (${REGION})"
    aws ec2 delete-key-pair --key-name ${KEY_NAME} --region ${REGION}
}

function create_instance() {
    REGION=$1
    IMAGE_ID=$2
    INSTANCE_TYPE=$3
    IAM_ROLE=$4
    SECURITY_GROUP=$5
    KEY_NAME=$6

    COUNT=1
    if [ ! -z $7 ]; then
        COUNT=$7
    fi

    echo "# run-instances: ${IMAGE_ID} (${REGION})"
    aws ec2 run-instances --region ${REGION} \
        --image-id ${IMAGE_ID} \
        --instance-type ${INSTANCE_TYPE} \
        --iam-instance-profile Name=${IAM_ROLE} \
        --key-name ${KEY_NAME} \
        --security-groups ${SECURITY_GROUP} \
        --tag-specifications "ResourceType=instance,Tags=[{Key=tag.key1,Value=${VALUE_1}},{Key=tag.key2,Value=${VALUE_2}}]" \
        --count ${COUNT}
}

case "$1" in
  'create.instance')
    create_instance $2 $3 $4 $5 $6 $7 $8
    ;;

  'copy.image')
    copy_image $2 $3 $4 $5
    ;;

  'copy.image.regions')
    copy_image_regions $2 $3 $4 ${REGIONS[@]}
    ;;

  'import.keypair')
    import_keypair $2 $3 $4
    ;;

  'import.keypair.regions')
    import_keypair_regions $2 $3 ${REGIONS[@]}
    ;;

  *)
    echo
    echo "Usage: $0 [options]"
    echo
    echo "# copy-image"
    echo "- copy.image <image name> <src image id> <src region> <dst region>"
    echo "- copy.image.regions <image name> <src image id> <src region>"
    echo
    echo "# create instance"
    echo "- create.instance <region> <image id> <instance type> <iam role> <security group> <key name>"
    echo "- create.instance.count <image id> <instance type> <iam role> <security group> <key name> <count>"
    echo
    echo "# import-key-pair"
    echo "- import.keypair <key name> <public key file> <region>"
    echo "- import.keypair.regions <key name> <public key file>"
    echo
    echo "# delete-key-pair"
    echo "- delete.keypair <key name> <region>"
    echo "- delete.keypair.regions <key name>"
    echo

esac
exit 0
