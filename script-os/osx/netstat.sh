#!/bin/bash

# https://benohead.com/blog/2013/07/31/mac-netstat-list-ports-programs/

netstat -an | grep LISTEN

lsof -P -iTCP -sTCP:LISTEN

