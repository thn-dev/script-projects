#!/bin/bash

# CITUSDB_HOME=/usr/local/Cellar/postgresql/9.5.3
# CITUSDB_BIN=$CITUSDB_HOME/bin

CWD=$(cd "$(dirname "$0")" && pwd)

function execute() {
  DB_NAME="$1"
  DB_SCRIPT="$2"

  psql -p 9700 -d $DB_NAME < $DB_SCRIPT
}

function execute_users() {
  DB_NAME="$1"
  DB_SCRIPT="$2"

  psql -p 9700 -d $DB_NAME < $DB_SCRIPT
  psql -p 9701 -d $DB_NAME < $DB_SCRIPT
  psql -p 9702 -d $DB_NAME < $DB_SCRIPT
}

case "$1" in
  'db.create')
    execute "$2" ddl_create.sql
    ;;

  'db.drop')
    execute "$2" ddl_drop.sql
    ;;

  'db.reset')
    $0 db.drop "$2"
    $0 db.create "$2"
    ;;

  'db.dist')
    execute "$2" setup_distributed-table.sql
    ;;

  'db.shards')
    execute "$2" setup_sharding.sql
    ;;

  'db.new')
    $0 db.drop "$2"
    $0 users.drop "$2"

    $0 db.create "$2"
    $0 db.dist "$2"
    $0 db.shards "$2"

    $0 users.create "$2"
    ;;

  'users.create')
    execute_users "$2" users_create.sql
    ;;

  'users.drop')
    execute_users "$2" users_drop.sql
    ;;

  'users.reset')
    $0 users.drop "$2"
    $0 users.create "$2"
    ;;

  *)
    echo
    echo "Usage: $0 options"
    echo "where option are"
    echo "- {db.create | db.drop | db.reset | db.dist | db.shards} <db name>"
    echo "- {users.create | users.drop | users.reset} <db name>"
    echo

esac
exit 0