#!/bin/bash

case "$1" in
    'start')
        systemctl start redis.service
        ;;

    'stop')
        systemctl stop redis.service
        ;;

    'status')
        systemctl status redis.service
        ;;

    'restart')
        systemctl restart redis.service
        ;;

    'enable')
        systemctl enable redis.service
        ;;

    'disable')
        systemctl disable redis.service
        ;;

    *)
        echo "Usage: $0 {start | stop | status | restart}"

esac
exit 0
