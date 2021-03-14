#!/bin/bash

# CITUSDB_HOME=/usr/local/Cellar/postgresql/<version>
# CITUSDB_BIN=$CITUSDB_HOME/bin

BASE_DIR="/var/lib/pgsql/9.5"
APP_DATA="$BASE_DIR/data"
APP_LOGS="$BASE_DIR/logs"

PG_HOME="/usr/pgsql-<version>"
PG_BIN="$PG_HOME/bin"

function init_db() {
  echo -e "\n# initializing the installation"
  mkdir -p $APP_DATA
  mkdir -p $APP_LOGS

  # create normal postgres instance
  sudo service postgresql-9.5 initdb || sudo $PG_BIN/postgresql95-setup initdb

  # set a configuration variable
  echo "shared_preload_libraries = 'citus'" | sudo tee -a $APP_DATA/postgresql.conf
}

function start_db() {
  echo -e "\n# starting postgresql instance"
  sudo service postgresql-9.5 restart
}

function stop_db() {
  echo -e "\n# stopping postgresql instance"
  $PG_BIN/pg_ctl -D $APP_DATA -m fast stop
}

function status_db() {
  echo -e "\n# postgresql instance's status"
  $PG_BIN/pg_ctl -D $APP_DATA status
}

function create_db() {
  DB_NAME="$1"
  echo -e "\n# creating database: $DB_NAME"

  $PG_BIN/createdb -p 9700 $DB_NAME
}

function drop_db() {
  DB_NAME="$1"
  echo -e "\n# dropping database: $DB_NAME"

  $PG_BIN/dropdb -p 9700 $DB_NAME
}

function load_db() {
  DB_NAME="$1"
  echo -e "\n# loading the extension"

  psql -p 9700 -d $DB_NAME -c "CREATE EXTENSION citus;"
}

function verify_db() {
  DB_NAME="$1"
  echo -e "\n# verifying the number of active worker nodes"

  psql -p 9700 -d $DB_NAME -c "select * from master_get_active_worker_nodes();"
}

function clear_db() {
    stop_db

    echo -e "\n# clearing the installation"
    rm -rf $APP_DATA/*
    rm -rf $APP_LOGS/*
}

case "$1" in
  'init')
    init_db
    start_db
    ;;

  'create')
    create_db "$2"
    load_db "$2"
    ;;

  'verify')
    verify_db "$2"
    ;;

  'drop')
    drop_db "$2"
    ;;

  'start')
    start_db
    ;;

  'stop')
    stop_db
    ;;

  'status')
    status_db
    ;;

  'clear')
    clear_db
    ;;

  *)
    echo "Usage: $0 {init | {create | drop <db name>} | start | stop | status | clear}"

esac
exit 0