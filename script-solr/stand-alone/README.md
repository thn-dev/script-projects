script-solr - stand-alone setup
===============================

The objective for this setup, a stand-alone SolrCloud, is to install and configure three instances of Solr with sharding. The default number of shards here is 3.

This setup has been tested with v4.5.0 or above

There are two sub-directories:

- bin (dir)
  - setenv.sh
  - solr.sh
  - sys (dir)
    - setup-solr.sh

- conf (dir)
  - core1.properties
  - core2.properties
  - core3.properties
  - schema.xml

Instructions
------------

Default assumptions (settings in bin/setenv.sh)

- Required Zookeeper Ensemble
- $APP_HOME=/opt --> installation location
- $APP_DATA=/data --> data location
- $USER_NAME and $GROUP_NAME --> owner of $APP_DATA
- $JAVA_HOME=/opt/java --> symlink to the location where Java JDK is installed
  + in OS X, JAVA_HOME=$(/usr/libexec/java_home)

Preparation

- Option 1: Install and configure a Zookeeper Ensemble in a stand-alone server
- Option 2: Install and configure a Zookeeper Ensemble in a cluster

For development, it is recommended to use the stand-alone configuration

Steps

1. Download solr, uncompress it, and move it to $APP_HOME location
2. Set parameters in bin/setenv.sh (if a value does not exist, set it up)
3. Set $SOLR_ORG in bin/sys/setup-solr.sh
4. Modify zookeeper hosts in bin/solr.sh if not using a stand-alone
5. Run bin/sys/setup-solr.sh with root or a sudo account

Operations

1. Login to $USER_NAME above
2. Execute "bin/solr.sh" and follow on-screen instructions
