#!/bin/bash

# URL: http://<es host>:<es port>/index
# i.e http://localhost:9200/test
ES_URL=$1

curl -XPUT $ES_URL?pretty=1

