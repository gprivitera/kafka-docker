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
    echo "listers=$KAFKA_LISTENERS" >> "$CONFIG"
    echo "advertised.listeners=$KAFKA_ADVERTISED_LISTENERS" >> "$CONFIG"
fi

exec "$@"
