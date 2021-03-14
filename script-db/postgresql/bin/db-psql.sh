#!/bin/bash

DB_HOST="localhost"
DB_PORT=5432
DB_USER="postgres"
DB_PWD="<pwd>"
DB_NAME="<name>"

case "$1" in
  'platforms.ssh')
    DB_HOST="localhost"
    DB_PORT=19700
    DB_NAME="platforms"
    DB_USER="postgres_admin"

    psql --dbname="${DB_NAME}" --host="${DB_HOST}" --port=${DB_PORT} --username="${DB_USER}" --password
    ;;

  'platforms.ssh.import')
    DB_HOST="localhost"
    DB_PORT=19700
    DB_NAME="platforms"
    DB_USER="postgres_admin"

    psql --dbname="${DB_NAME}" --host="${DB_HOST}" --port=${DB_PORT} --username="${DB_USER}" --password < $2
    ;;

  'psql.local.platforms')
    DB_NAME="platforms"

    psql --dbname="${DB_NAME}"
    ;;

  'psql.local')
    DB_NAME="postgres"

    psql --dbname="${DB_NAME}"
    ;;

  *)
    echo "Usage: $0 { psql.local | psql.local.platforms | platforms | platforms.ssh | platforms.ssh.import }"

esac
exit 0
