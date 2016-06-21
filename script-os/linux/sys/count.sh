#!/bin/bash

find $1/* -maxdepth 0 -type d -exec bash -c "echo -n {} ; ls -lR {} | wc -l" \;
