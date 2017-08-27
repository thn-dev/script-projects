#!/bin/bash

case "$1" in
  'sublime')
    $HOME/tools/sublime_text_3/sublime_text &
    ;;

  'eclipse')
    $HOME/tools/eclipse-neon/eclipse &
    ;;

  'jb-go')
    $HOME/tools/jb-go/bin/gogland.sh &
    ;;

  'jb-java')
    $HOME/tools/jb-java/bin/idea.sh &
    ;;

  *)
    echo "Usage: $0 {sublime | eclipse | jb-go | jb-java}"

esac
exit 0

