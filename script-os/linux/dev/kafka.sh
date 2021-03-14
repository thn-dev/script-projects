#!/bin/bash

CWD=$(cd "$(dirname "$0")" && pwd)

APP_HOME=/opt/kafka
APP_BIN=$APP_HOME/bin
APP_CONFIG=$APP_HOME/config

APP_DATA=/data/kafka

ZK_CONNECT=flax:2181
KAFKA_SERVER=flax:9092

case "$1" in
    'zk.start')
        $APP_BIN/zookeeper-server-start.sh $APP_CONFIG/zookeeper.properties &
        ;;

    'zk.stop')
        $APP_BIN/zookeeper-server-stop.sh $APP_CONFIG/zookeeper.properties &
        ;;

    'k.start')
        $APP_BIN/kafka-server-start.sh $APP_CONFIG/server.properties &
        ;;

    'k.stop')
        $APP_BIN/kafka-server-stop.sh $APP_CONFIG/server.properties &
        ;;

    'k.clear')
        rm -rf $APP_DATA/klogs/*
        rm -rf $APP_DATA/zk/{data,logs}/*        
        ;;

    'k.producer')
        $APP_BIN/kafka-console-producer.sh --broker-list $KAFKA_SERVER --topic $2
        ;;

    'k.consumer')
        $APP_BIN/kafka-console-consumer.sh --zookeeper $ZK_CONNECT --from-beginning --topic $2
        ;;

    'k.configs.topics')
        $APP_BIN/kafka-configs.sh --zookeeper $ZK_CONNECT --describe --entity-type topics
        ;;

    'k.configs.clients')
        $APP_BIN/kafka-configs.sh --zookeeper $ZK_CONNECT --describe --entity-type clients
        ;;

    'kb.start')
        $APP_BIN/kafka-server-start.sh $APP_CONFIG/server-0.properties &
        $APP_BIN/kafka-server-start.sh $APP_CONFIG/server-1.properties &
        $APP_BIN/kafka-server-start.sh $APP_CONFIG/server-2.properties &
        ;;

    'kb.clear')
        rm -rf $APP_DATA/{klogs-0,klogs-1,klogs-2}/*
        rm -rf $APP_DATA/zk/{data,logs}/*        
        ;;

    'kb.topic.create')
        PARTITIONS=$3
        if [ -z "$3" ]; then
            PARTITIONS=1
        fi
 
        REPLICATION_FACTOR=$4
        if [ -z "$4" ]; then
            REPLICATION_FACTOR=3
        fi
        $APP_BIN/kafka-topics.sh --create --zookeeper $ZK_CONNECT --replication-factor $REPLICATION_FACTOR --partitions $PARTITIONS --topic $2
        ;;

    'topic.create')
        PARTITIONS=$3
        if [ -z "$3" ]; then
            PARTITIONS=1
        fi
 
        REPLICATION_FACTOR=$4
        if [ -z "$4" ]; then
            REPLICATION_FACTOR=1
        fi

        $APP_BIN/kafka-topics.sh --create --zookeeper $ZK_CONNECT --replication-factor $REPLICATION_FACTOR --partitions $PARTITIONS --topic $2
        ;;

    'topic.delete')
        $APP_BIN/kafka-topics.sh --delete --zookeeper $ZK_CONNECT --topic $2 
        ;;

    'topic.list')
        $APP_BIN/kafka-topics.sh --list --zookeeper $ZK_CONNECT
        ;;

    'topic.purge')
        $APP_BIN/kafka-configs.sh --zookeeper $ZK_CONNECT --alter --entity-type topics --entity-name $2 --add-config retention.ms=$3
        ;;

    'topic.purge.reset')
        $APP_BIN/kafka-configs.sh --zookeeper $ZK_CONNECT --alter --entity-type topics --entity-name $2 --delete-config retention.ms
        ;;

    'topic.describe')
        $APP_BIN/kafka-topics.sh --describe --zookeeper $ZK_CONNECT --topic $2
        ;;

    *)
        echo ""
        echo "Usage: $0 options"
        echo "where options are:"
        echo "- zk.start - stop zookeeper"
        echo "- zk.stop  - stop zookeeper"
        echo ""
        echo "- k.start - start kafka server"
        echo "- k.stop  - stop kafka server"
        echo "- k.clear  - reset kafka server"
        echo "- k.producer <topic name> - launch kafka producer"
        echo "- k.consumer <topic name> - launch kafka consumer"
        echo ""
        echo "- kb.start - start multi-broker kafka servers"
        echo "- kb.clear - reset multi-broker kafka servers"
        echo "- kb.topic.create <topic name>  [number of partitions (1)] [replication factor (3)]- create a topic in multi-broker environment"
        echo ""
        echo "- topic.describe <topic name> - create a topic"
        echo "- topic.delete <topic name> - delete a topic"
        echo "- topic.create <topic name> [number of partitions (1)] [replication factor (1)] - create a topic"
        echo "- topic.purge <topic name> <time in ms> - purge messages at given topic"
        echo "- topic.purge.reset <topic name> - reset parameter to purge messages at given topic"
        echo "- topic.list - display a list of topic(s)"
        echo ""

esac
exit 0
