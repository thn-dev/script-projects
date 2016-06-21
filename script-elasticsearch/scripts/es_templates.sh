#!/bin/bash

# URL: http://<es host>:<es port>/index
# i.e http://localhost:9200/test
ES_URL=$1
ES_TEMPLATE=$2

ES_SHARDS=1
if [ ! -z $3 ]; then
  ES_SHARDS = $3
fi

ES_REPLICAS=1
if [ ! -z $4 ]; then
  ES_REPLICAS = $4
fi

curl -XPUT $ES_URL/_template/template_$ES_TEMPLATE?pretty=1 -d'
{
  "template": '\""$ES_TEMPLATE"*\",'
  "aliases": {
    '\""$ES_TEMPLATE"\"': {}
  },
  "settings": {
    "number_of_shards": '"$ES_SHARDS",'
    "number_of_replicas": '"$ES_REPLICAS"',
    "analysis": {
      "analyzer": {
        "general_analyzer": {
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
  },
  "mappings": {
    "general": {
      "_all": {"type": "string", "analyzer": "general_analyzer"},
      "properties": {
        "idate": {"type": "string", "analyzer": "keyword"},
        "frm": {"type": "string", "analyzer": "keyword"},
        "to": {"type": "string", "analyzer": "email_analyzer"},
        "path": {"type": "string", "analyzer": "keyword"}
      }
    }
  }
}
'
