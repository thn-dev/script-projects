#!/bin/bash

# URL: http://<es host>:<es port>/<index>/<type>
# (i.e. http://localhost:9200/unit/test)

ES_URL=$1

curl -XPOST $ES_URL/_search?pretty=1 -d'
{
  "aggs": {
    "column_name": {
      "filter": {
        "term": { "field_name": "field_value" }
      },
      "aggs": {
        "column_stats": {
          "stats": { "field": "column_name" }
        }
      }
    }
  }
}'

