
#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)
. $CWD/../yarn-env.sh

# setup hadoop dfs for datanode
mkdir -p $HADOOP_DATA/dfs/dn
chown -R $USER_NAME:$GROUP_NAME $HADOOP_DATA
