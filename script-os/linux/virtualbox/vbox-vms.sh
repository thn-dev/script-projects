#!/bin/bash

case "$1" in
    'list')
        vboxmanage list vms
        vboxmanage list runningvms
        ;;

    'stop')
        vboxmanage controlvm vm-name poweroff &
        ;;

    'start')
        vboxheadless -s vm-name &
        ;;

    *)
        ehco "Usage: $0 {list | start | stop}"
esac
exit 0