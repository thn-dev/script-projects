#!/bin/bash

# URL: http://<es host>:<es port>/<index>/<type>
# (i.e. http://localhost:9200/unit/test)

ES_URL=$1

curl -XGET $ES_URL/_count?pretty=1

