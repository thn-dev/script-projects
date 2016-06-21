#!/bin/bash

# URL: http://<es host>:<es port>/index/type
ES_URL=$1

curl -XDELETE $ES_URL?pretty=1

