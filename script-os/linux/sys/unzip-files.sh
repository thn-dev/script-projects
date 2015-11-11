#!/bin/bash

INPUT_DIR=$1
OUTPUT_DIR=$2

FILE_EXT="xml"
if [ "$3" != "" ]; then
  FILE_EXT="$3"
fi

cd $INPUT_DIR

for f in *.zip;
do 
  unzip -n "$f" -d "$f"dir;
done;\

for f in *.zipdir;
do 
  find . -type f -path "./$f/*.zip" -exec unzip -n '{}' "*.$FILE_EXT" -d "$OUTPUT_DIR/$f.$FILE_EXT" \;;
done;
