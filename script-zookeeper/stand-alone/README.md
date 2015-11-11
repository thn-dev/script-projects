The objective for this setup, a Zookeeper Ensemble in a stand-alone machine, is to install and configure 3 instances of zookeeper using the compressed file, which can be downloaded directly from zookeeper.apache.org, as is.

This setup has been tested with v3.4.5 and v3.4.6

There are two sub-directories:

- bin (dir)
  - setenv.sh
  - zk.sh
  - sys (dir)
    - setup-zk.sh

- conf (dir)
  - zoo1.cfg
  - zoo2.cfg
  - zoo3.cfg

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

Testing connection

Once Zookeepers are up and running, run the following command

$APP_HOME/<zookeeper instance>/bin/zkCli.sh -server <zookeeper node:port>

For example,
- to connect to zks1:
  $APP_HOME/zks1/bin/zkCli.sh -server localhost:2181

- to connect to zks2:
  $APP_HOME/zks1/bin/zkCli.sh -server localhost:2182

- to connect to zks3:
  $APP_HOME/zks1/bin/zkCli.sh -server localhost:2183
