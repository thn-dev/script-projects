#!/bin/bash

case "$1" in
  'shd')
    VBOX_FILE=$2
    /usr/bin/vboxmanage internalcommands sethduuid $VBOX_FILE
    ;;

  'osx')
    VBOX_VM=$2
    /usr/bin/vboxmanage modifyvm $VBOX_VM --firmware efi64
    /usr/bin/vboxmanage setextradata $VBOX_VM VBoxInternal2/EfiGopMode 4
    /usr/bin/vboxmanage setextradata $VBOX_VM VBoxInternal2/SmcDeviceKey  "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
    ;;

  *)
    echo "Usage: $0 {shd vbox-file | osc vbox-vm}"

esac
exit 0
