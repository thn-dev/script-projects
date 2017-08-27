
#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/../yarn-env.sh

# setup hadoop dfs for secondary namenode
mkdir -p $HADOOP_DATA/dfs/sn
chown -R $USER_NAME:$GROUP_NAME $HADOOP_DATA
