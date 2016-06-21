#!/bin/bash

# URL: http://<es host>:<es port>/index
# i.e http://localhost:9200/test
ES_URL=$1

curl -XPUT $ES_URL?pretty=1 -d'
{
  "settings": {
    "analysis": {
      "analyzer": {
        "en_analyzer": {
          "type": "english",
          "filter": ["standard", "lowercase", "en_stop"],
          "tokenizer": "uax_url_email"
        },
        "email_analyzer": {
          "filter": ["standard", "lowercase"],
          "tokenizer": "uax_url_email"
        },
        "path_analyzer": {
          "filter": ["standard", "lowercase", "stop"],
          "tokenizer": "forward_slash"
        },
        "dot_analyzer": {
          "filter": ["standard", "lowercase", "stop"],
          "tokenizer": "dot_path"
        }
      },
      "tokenizer": {
        "forward_slash": {
          "type": "path_hierarchy",
          "delimiter": "/"
        },
        "dot_path": {
          "type": "path_hierarchy",
          "delimiter": "."
        }
      },
      "filter": {
        "en_stop": {
          "type": "stop",
          "stopwords_path": "stopwords/stopwords_en.txt"
        }
      }
    }
  }
}'

