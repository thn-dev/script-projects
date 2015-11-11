#!/bin/bash

# URL: http://<es host>:<es port>/<index>/<type>
# (i.e. http://localhost:9200/unit/test)

ES_URL=$1

curl -XPOST $ES_URL/_search?pretty=1 -d'
{
  "query": {
    "match": {
        "query": "test"
    }
  }
}'

