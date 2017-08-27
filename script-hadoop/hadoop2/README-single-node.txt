Instructions to Setup a Single-Node Hadoop Cluster (v2.7.3)

# required files
- jdk-<version>.tar.gz
- hadoop-2.7.3.tar.gz
- <setup>.zip

# login as root
- unzip hadoop-2.7.3.zip to <deploy home> --> /opt
  (do not create a symlink)

- install and setup Java JDK (v1.8.x)
  + unzip jdk-<version>.tar.gz to /opt
  + use alternatives (use URL)

- unzip <setup>.zip to <setup dir>

- setup an account (default - username: yarn, groupname: hadoop)
  + goto <setup dir>/bin/sys
  + run "./create-user.sh add" <-- to add a new user and group

- setup <deploy data> top directory --> /data

- setup hadoop cluster
  + goto <setup dir>/bin/sys
  + run "./setup.sh all"

# login as <user name> (default: yarn)
- setup SSH passwordless login
  + goto /home/<user name>/bin
  + run "./setup-ssh.sh"
  + run "./setup-ssh_share.sh localhost"

  Test
  + run "ssh localhost" <-- it should not ask you for a password

- format HDFS
  + goto /home/<user name>/bin
  + run ". ./yarn-env.sh"

  or edit $HOME/.bash_profile to add JAVA_HOME and HADOOP_PREFIX to PATH
  (see info in $HOME/bin/yarn-env.sh)

  + run "hdfs namenode -format"

- bring up the cluster
  + goto /home/<user name>/bin
  + run "./yarn.sh start"

- shutdown the cluster
  + goto /home/<user name>/bin
  + run "./yarn.sh stop"

- reset the cluster
  + goto /home/<user name>/bin
  + run "./yarn.sh reset"

# links
- NameNode
  http://localhost:50070

- Resource Manager
  http://localhost:8088

- MapReduce Job History Server
  http://localhost:19888

  # references
  - single node cluster
    http://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html

