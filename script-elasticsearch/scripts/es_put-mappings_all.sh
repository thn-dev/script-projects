#!/bin/bash

# URL: http://<es host>:<es port>/index/type
# i.e http://localhost:9200/test/type
ES_URL=$1

curl -XPUT $ES_URL?pretty=1 -d'
{
  "mappings": {
    "general": {
      "_all": {
        "type": "string",
        "analyzer": "email_analyzer"
      },
      "properties": {
        "cdate": {
          "type": "string",
          "analyzer": "keyword"
        },
        "frm": {
          "type": "string",
          "analyzer": "keyword"
        },
        "to": {
          "type": "string",
          "analyzer": "email_analyzer"
        },
        "path": {
          "type": "string",
          "analyzer": "keyword"
        }
      }
    }
  },
  "settings": {
    "analysis": {
      "analyzer": {
        "en_analyzer": {
          "type": "english",
          "stopwords_path": "stopwords/stopwords_en.txt"
        },
        "email_analyzer": {
          "filter": ["standard", "lowercase", "stop"],
          "tokenizer": "uax_url_email"
        }
      }
    }
  }
}'
