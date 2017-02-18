#!/bin/bash

case "$1" in
    'start')
        systemctl start mysqld
        ;;

    'stop')
        systemctl stop mysqld
        ;;

    'status')
        systemctl status mysqld
        ;;

    'restart')
        systemctl restart mysqld
        ;;

    *)
        echo "Usage: $0 {start | stop | status | restart}"

esac
exit 0
