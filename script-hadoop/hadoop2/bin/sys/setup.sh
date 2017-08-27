#!/bin/bash

case "$1" in
  "nn-only")
    echo -e "exec setup-yarn.sh"
    ./setup-yarn.sh

    echo -e "exec setup-nn.sh"
    ./setup-nn.sh
    ;;

  "sn-only")
    echo -e "exec setup-yarn.sh"
    ./setup-yarn.sh

    echo -e "exec setup-sn.sh"
    ./setup-sn.sh
    ;;

  "dn-only")
    echo -e "exec setup-yarn.sh"
    ./setup-yarn.sh

    echo -e "exec setup-dn.sh"
    ./setup-dn.sh
    ;;

  "nn-dn")
    echo -e "exec setup-yarn.sh"
    ./setup-yarn.sh

    echo -e "exec setup-nn.sh"
    ./setup-nn.sh

    echo -e "exec setup-dn.sh"
    ./setup-dn.sh
    ;;

  "sn-dn")
    echo -e "exec setup-yarn.sh"
    ./setup-yarn.sh

    echo -e "exec setup-nn.sh"
    ./setup-nn.sh

    echo -e "exec setup-dn.sh"
    ./setup-dn.sh
    ;;

  *)
    echo "Usage: $0 {nn-only | sn-only | dn-only | nn-dn | sn-dn}"

esac
exit 0
