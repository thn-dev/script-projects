#!/bin/bash

# URL: http://<es host>:<es port>/index
# i.e http://localhost:9200/test
ES_URL=$1
ES_TEMPLATE=$2

curl -XDELETE $ES_URL/_template/$ES_TEMPLATE?pretty=1

