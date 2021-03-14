#!/bin/bash

# CITUSDB_HOME=/usr/local/Cellar/postgresql/<version>
# CITUSDB_BIN=$CITUSDB_HOME/bin

CWD=$(cd "$(dirname "$0")" && pwd)

APP_DATA="/data/citus"
APP_LOG="$APP_DATA/log"

function init_db() {
  echo -e "\n# initializing the installation"

  mkdir -p $APP_DATA/{master,worker1,worker2}
  mkdir -p $APP_LOG

  # create three normal postgres instances
  initdb -D $APP_DATA/master
  initdb -D $APP_DATA/worker1
  initdb -D $APP_DATA/worker2

  # set workers in master
  echo "localhost 9701" >> $APP_DATA/master/pg_worker_list.conf
  echo "localhost 9702" >> $APP_DATA/master/pg_worker_list.conf

  # set a configuration variable
  echo "shared_preload_libraries = 'citus'" >> $APP_DATA/master/postgresql.conf
  echo "shared_preload_libraries = 'citus'" >> $APP_DATA/worker1/postgresql.conf
  echo "shared_preload_libraries = 'citus'" >> $APP_DATA/worker2/postgresql.conf
}

function start_db() {
  echo -e "\n# starting master instance"
  pg_ctl -D $APP_DATA/master -o "-p 9700" -l $APP_LOG/master.log start

  echo -e "\n# starting worker1 instance"
  pg_ctl -D $APP_DATA/worker1 -o "-p 9701" -l $APP_LOG/worker1.log start

  echo -e "\n# starting worker2 instance"
  pg_ctl -D $APP_DATA/worker2 -o "-p 9702" -l $APP_LOG/worker2.log start
}

function stop_db() {
  echo -e "\n# stopping worker1 instance"
  pg_ctl -D $APP_DATA/worker1 -m fast stop

  echo -e "\n# stopping worker2 instance"
  pg_ctl -D $APP_DATA/worker2 -m fast stop

  echo -e "\n# stopping master instance"
  pg_ctl -D $APP_DATA/master -m fast stop
}

function status_db() {
  echo -e "\n# worker1 instance's status"
  pg_ctl -D $APP_DATA/worker1 status

  echo -e "\n# worker2 instance's status"
  pg_ctl -D $APP_DATA/worker2 status

  echo -e "\n# master instance's status"
  pg_ctl -D $APP_DATA/master status
}

function create_db() {
  DB_NAME="$1"
  echo -e "\n# creating database: $DB_NAME"

  createdb -p 9700 $DB_NAME
  createdb -p 9701 $DB_NAME
  createdb -p 9702 $DB_NAME
}

function drop_db() {
  DB_NAME="$1"
  echo -e "\n# dropping database: $DB_NAME"

  dropdb -p 9700 $DB_NAME
  dropdb -p 9701 $DB_NAME
  dropdb -p 9702 $DB_NAME
}

function load_ext() {
  DB_NAME="$1"
  echo -e "\n# loading the extension"

  psql -p 9700 -d $DB_NAME -c "CREATE EXTENSION citus;"
  psql -p 9701 -d $DB_NAME -c "CREATE EXTENSION citus;"
  psql -p 9702 -d $DB_NAME -c "CREATE EXTENSION citus;"
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
}

case "$1" in
  'init')
    init_db
    start_db
    ;;

  'create')
    create_db "$2"
    load_ext "$2"
    verify_db "$2"
    ;;

  'drop')
    drop_db "$2"
    ;;

  'verify')
    verify_db "$2"
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
    echo "Usage: $0 (init | {create | drop | verify <db name>} | start | stop | status | clear)"

esac
exit 0