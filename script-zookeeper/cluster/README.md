The objective for this setup, a Zookeeper Ensemble in a cluster environment (typically three nodes), is to install and configure an instance of zookeeper per node using the compressed file, which can be downloaded directly from zookeeper.apache.org, as is.

This setup has been tested with v3.4.5 and v3.4.6

There are two sub-directories:

- bin (dir)
  - setenv.sh
  - zk.sh
  - sys (dir)
    - setup-zk.sh

- conf (dir)
  - zoo.cfg

Instructions
------------

Default assumptions (settings in bin/setenv.sh)

- $APP_HOME=/opt --> installation location
- $APP_DATA=/data --> data location
- $USER_NAME and $GROUP_NAME --> owner of $APP_DATA
- $JAVA_HOME=/opt/java --> symlink to the location where Java JDK is installed
  + in OS X, JAVA_HOME=$(/usr/libexec/java_home)

Steps

1. Download zookeeper, uncompress it, and move the directory to $APP_HOME location
2. Set parameters in bin/setenv.sh (if a value does not exist, set it up)
3. Set $ZK_ORG in bin/sys/setup-zk.sh
4. Run bin/sys/setup-zk.sh with root or a sudo account

Operations

1. Login to $USER_NAME above
2. Execute "bin/zk.sh" and follow on-screen instructions

--oo0oo--

It is recommended to use three nodes to setup Zookeeper Ensemble so after using the instructions below to setup Zookeeper in each node. One needs to do the following to create a Zookeeper Ensemble environment:

Let's say, there are zk_server1, zk_server2, and zk_server3
- shutdown all zookeeper instances if they are running

- edit $APP_HOME/zookeeper/conf/zoo.cfg at each server
  server.1=zk_server1:2888:3888
  server.2=zk_server2:2888:3888
  server.3=zk_server3:2888:3888

- edit $APP_DATA/zookeeper/data/myid
  at zk_server2, change from 1 to 2
  at zk_server3, change from 1 to 3

--oo0oo--

Testing connection

From any zookeeper node, run the following command

$APP_HOME/zookeeper/bin/zkCli.sh -server <zookeeper node>

For example,
- to connect to zk_server1 (assuming using default port number 2181):
  $APP_HOME/zookeeper/bin/zkCli.sh -server zk_server1

- to connect to zk_server1 (assuming it's configured with port number 2185):
  $APP_HOME/zookeeper/bin/zkCli.sh -server zk_server1:2185
