#!/bin/bash

# URL: http://<es host>:<es port>/index
# i.e http://localhost:9200/test
ES_URL=$1
ES_TEMPLATE=$2

ES_SHARDS=1
if [ ! -z $3 ]; then
  ES_SHARDS=$3
fi

ES_REPLICAS=1
if [ ! -z $4 ]; then
  ES_REPLICAS=$4
fi

curl -XPUT $ES_URL/_template/template_$ES_TEMPLATE?pretty=1 -d'
{
  "template": '"$ES_TEMPLATE*"',
  "aliases": {
    '"$ES_TEMPLATE"': {}
  },
  "settings": {
    "number_of_shards": '"$ES_SHARDS"',
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
    "_default_": {
      "_all": {"type": "string"},
      "properties": {
        "abstract": {
          "properties": {
            "abstract": {
              "type": "string",
              "fields": {
                "ar": {"type": "string", "analyzer": "arabic"},
                "fr": {"type": "string", "analyzer": "french"},
                "ru": {"type": "string", "analyzer": "russian"},
                "en": {"type": "string", "analyzer": "english"}
              }
            }
          }
        },
        "title": {
          "properties": {
            "title": {
              "type": "string",
              "fields": {
                "ar": {"type": "string", "analyzer": "arabic"},
                "fr": {"type": "string", "analyzer": "french"},
                "ru": {"type": "string", "analyzer": "russian"},
                "en": {"type": "string", "analyzer": "english"}
              }
            }
          }
        },
        "links": {
          "type": "nested",
          "properties": {
            "linktype": {"type": "string", "index": "not_analyzed"},
            "anchor": {"type": "string", "index": "not_analyzed"},
            "link": {"type": "string", "index": "analyzed", "analyzer": "path_analyzer"}
          }
        },
        "url": {"type": "string", "index": "analyzed", "analyzer": "path_analyzer"}
      }
    }
  }
}
'
