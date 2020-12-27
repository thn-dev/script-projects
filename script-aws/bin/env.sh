#!/usr/bin/env bash

ACCOUNT_ID="1234567890"

REGION="us-east-1"

declare -a REGIONS_EXP=(
    "us-east-1" "us-east-2"
    "us-west-1" "us-west-2"
)

declare -a REGIONS_ALL=(
    "us-east-1" "us-east-2"
    "us-west-1" "us-west-2"
    "ap-east-1"
    "ap-south-1"
    "ap-northeast-1" "ap-northeast-2"
    "ap-southeast-1" "ap-southeast-2"
    "ca-central-1"
    "eu-central-1"
    "eu-west-1" "eu-west-2" "eu-west-3"
    "eu-north-1"
    "me-south-1"
    "sa-east-1"
)

declare -a REGIONS=${REGIONS_ALL[@]}
