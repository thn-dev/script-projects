#!/bin/bash

case "$1" in
	'sublime')
    $HOME/tools/sublime_text_3/sublime_text &
    ;;

	'eclipse')
		$HOME/tools/eclipse-luna/eclipse &
    ;;

	*)
		echo "Usage: $0 {sublime | eclipse}"

esac
exit 0

