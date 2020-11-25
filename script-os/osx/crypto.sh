#!/bin/bash

case "$1" in
  "md5")
    echo -n "$2" | md5sum
    ;;

  "sha1")
    echo -n "$2" | shasum
    ;;

  "sha256")
    echo -n "$2" | shasum -a 256
    ;;

  "sha512")
    echo -n "$2" | shasum -a 512
    ;;

  "base64")
    echo -n "$2" | base64
    ;;

  "base64.d")
    echo -n "$2" | base64 -D
    ;;

  *)
    echo "Usage: $0 { md5 | sha1 | sha256 | sha512 | base64 | base64.d } string-value"

esac
exit 0
