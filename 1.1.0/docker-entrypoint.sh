#!/bin/bash

set -e

# Generate the server.properties only if it doesn't exist
if [ ! -f "$KAFKA_CONF_DIR/server.properties" ]; then
    CONFIG="$KAFKA_CONF_DIR/server.properties"

    echo "broker.id=$KAFKA_BROKER_ID" >> "$CONFIG"
    echo "zookeeper.connect=$KAFKA_ZOOKEEPER_CONNECT" >> "$CONFIG"
    echo "log.dirs=$KAFKA_LOGS_DIR" >> "$CONFIG"
    echo "num.partitions=$KAFKA_NUM_PARTITIONS" >> "$CONFIG"
    echo "default.replication.factor=$KAFKA_DEFAULT_REPLICATION_FACTOR" >> "$CONFIG"
    echo "offsets.topic.replication.factor=$KAFKA_OFFSET_TOPIC_REPLICATION_FACTOR" >> "$CONFIG"

    if [ ! -z "$CURRENT_KAFKA_VERSION" ]; then
      echo "inter.broker.protocol.version=$CURRENT_KAFKA_VERSION" >> "$CONFIG"
    fi

    if [ ! -z "$CURRENT_MESSAGE_FORMAT_VERSION" ]; then
      echo "log.message.format.version=$CURRENT_MESSAGE_FORMAT_VERSION" >> "$CONFIG"
    fi

    if [ ! -z "$KAFKA_LISTENERS" ]; then
        echo "listers=$KAFKA_LISTENERS" >> "$CONFIG"
    fi

    if [ ! -z "$KAFKA_ADVERTISED_LISTENERS" ]; then
        echo "advertised.listeners=$KAFKA_ADVERTISED_LISTENERS" >> "$CONFIG"
    fi
fi

exec "$@"
