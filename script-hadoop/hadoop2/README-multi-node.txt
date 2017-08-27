Instructions to Setup a Multi-Node Hadoop Cluster (v2.7.3)

# required user account (root user or a user with root privileges)
- assuming this user has SSH passwordless setup from a namenode to other nodes
  (if not, set it up)

# required files
- jdk-<version>.tar.gz
- hadoop-2.7.3.tar.gz
- <setup>.zip

# (name node) login as root
- make use of
  + remote-cp.sh <-- to copy a file to multiple nodes
  + remote-ex.sh <-- to execute the same command at multiple nodes

- upload required files to all nodes (use remote-cp.sh)

- unzip hadoop-2.7.3.zip to /opt
  (do not create a symlink)

  --> use remote-ex.sh to do the same thing at all nodes

- install and setup Java JDK (v1.8.x)
  + unzip jdk-<version>.tar.gz to /opt
  + use alternatives (use URL)

  --> use remote-ex.sh to do the same thing at all nodes

- unzip <setup>.zip to <setup dir>
  --> use remote-ex.sh to do the same thing at all nodes

- setup an account (default - username: yarn, groupname: hadoop)
  + goto <setup dir>/bin/sys
  + run "./create-user.sh add" <-- to add a new user and group

  --> have to login at each node and do this manually for new account
  --> use remote-ex.sh to create new group and add existing account into the new group
      (check commands in create-user.sh)

- setup <deploy data> top directory /data
  --> use remote-ex.sh to do the same thing at all nodes

- setup hadoop cluster
  + goto <setup dir>/bin/sys
  + run "./setup.sh nn-only" <-- to setup name node only
  + run "./setup.sh nn-dn" <-- to setup name node and data node together

# (secondary name node) login as root
- setup hadoop cluster
  + goto <setup dir>/bin/sys
  + run "./setup.sh sn-only" <-- to setup a secondary name node only
  + run "./setup.sh sn-dn" <-- to setup secondary name node and data node together

  --> can use remote-ex.sh at the name node to do the same thing at the secondary name node

# (data node) login as root
- setup hadoop cluster
  + goto <setup dir>/bin/sys
  + run "./setup.sh dn-only" <-- to setup a data node only

  --> can use remote-ex.sh at the name node to do the same thing at other data nodes

# (name node) login as <user name> (default: yarn)
- setup SSH passwordless login
  + goto /home/<user name>/bin
  + run "./setup-ssh.sh"
  + run "./setup-ssh_share-hosts.sh <host file>"

  <host file> contains all nodes in the cluster

  Test
  + run "ssh <other node>" <-- it should not ask you for a password

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
  http://<name node>:50070

- Resource Manager
  http://<name node>:8088

- MapReduce Job History Server
  http://<name node>:19888

  # references
  - cluster setup
    http://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/ClusterSetup.html
