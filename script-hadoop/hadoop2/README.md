This directory contains scripts and configuration files for setting up a single-node Hadoop Cluster for development and testing.

# Instructions
The following instructions were tested in Linux/CentOS environment with Hadoop v2.x

## Assumptions and Preparation
- Java SE - download v1.6.x or better and install it at JAVA_HOME=/opt/java
- Hadoop - download v2.x and untar it to /opt

## Steps
- login with root privilege

- goto this "hadoop2" directory

- goto "bin" directory and edit "setenv.sh" to setup the following if needed
  - USER_NAME (default: hduser)
  - USER_HOME (default: /home/hduser)
  - GROUP_NAME (default: hadoop)

- goto "bin/sys" directory
  - run "./create-user.sh" to create a default user to run and manage the Hadoop Cluster
  - run "./setup-hadoop.sh" to setup up the single-node Hadoop Cluster

- login as the default user created above

- goto "bin" directory
  - run "./setup-ssh.sh" to generate SSH passphraseless keys

  - edit ".bash_profile" (linux) or ".profile" (osx) to
    - add JAVA_HOME (JAVA_HOME=/opt/java;export JAVA_HOME)
    - add HADOOP_PREFIX (HADOOP_PREFIX=/opt/hadoop;export HADOOP_PREFIX)
    - update PATH (PATH=$JAVA_HOME/bin:$HADOOP_PREFIX/bin:$PATH)

  - run "hadoop namenode -format <cluster name>" to initialize the Hadoop Cluster

  - run "./yarn.sh start" to start the Hadoop Cluster
    - verify Hadoop Distributed Filesystem (HDFS)
      - open http://localhost:50070

    - verify Resource Manager
      - open http://localhost:8088

    - verify MapReduce Job History
      - open http://localhost:19888

  - run "./yarn.sh stop" to stop the Hadoop Cluster
