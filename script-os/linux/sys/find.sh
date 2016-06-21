#!/bin/bash

case "$1" in
  "find.text" )
    INPUT_DIR="$2"
    SEARCH_STRING="$3"

    find $INPUT_DIR -type f -exec grep -l "$SEARCH_STRING" {} +
    ;;

  "count.files" )
    INPUT_DIR="$2"

    find $INPUT_DIR/* -maxdepth 0 -type d -exec bash -c "echo -n {} ; ls -lR {} | wc -l" \;
    ;;

  "find.lines.exact" )
    INPUT_DIR="$2"
    SEARCH_STRING="$3"

    # find with exact match
    grep -n --colour -Hrn "$SEARCH_STRING" "$INPUT_DIR"
    ;;

  "find.lines" )
    INPUT_DIR="$2"
    SEARCH_STRING="$3"

    # find with case insensitive
    grep -n --colour -Rin "$SEARCH_STRING" "$INPUT_DIR"
    ;;

  *)
    echo "Usage: $0 <options>"
    echo "options are"
    echo "- find.text <input directory> <search string>"
    echo "- find.lines.exact <input directory> <search string>"
    echo "- find.lines <input directory> <search string>"
    echo "- count.files <input directory>"
    echo ""

esac
exit 0
